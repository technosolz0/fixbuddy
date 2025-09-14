import 'package:dio/dio.dart';
import 'package:fixbuddy/app/constants/custom_overlay.dart';
import 'package:fixbuddy/app/data/models/user_cached_model.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/services/auth_api_service.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:fixbuddy/app/utils/servex_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class VerifyOtpController extends GetxController {
  final otpControllers = List.generate(6, (_) => TextEditingController());
  final isLoading = false.obs;
  final isResending = false.obs;

  final AuthApiService _apiService = AuthApiService();
  final LocalStorage _localStorage = LocalStorage();

  String get otp => otpControllers.map((controller) => controller.text).join();

  Future<void> handleOtpVerification(String email, String flowType) async {
    if (otp.length < 6) {
      ServexUtils.showSnackbar(
        SnackType.error,
        'Please enter complete 6-digit OTP',
      );
      return;
    }

    isLoading.value = true;
    ServexUtils.showLoader();

    try {
      if (flowType == 'register') {
        await _verifyRegisterOtp(email);
      } else if (flowType == 'login') {
        await _verifyLoginOtp(email);
      } else {
        ServexUtils.showSnackbar(SnackType.error, 'Unknown flow type');
      }
    } catch (e) {
      ServexUtils.showSnackbar(SnackType.error, 'Unexpected error: $e');
    } finally {
      isLoading.value = false;
      ServexUtils.hideLoader();
    }
  }

  Future<void> _verifyRegisterOtp(String email) async {
    try {
      final response = await _apiService.verifyRegistrationOtp(
        email: email,
        otp: otp,
      );

      if (response?.statusCode == 200) {
        final data = response!.data;
        final token = data['access_token'];
        final message = data['message'] ?? 'Login successful!';

        if (token != null) {
          await _saveUserSession(data);
          await _localStorage.setToken(token);
        }

        ServexUtils.showSnackbar(SnackType.success, message);
        Get.offAllNamed(Routes.mainScreen);
      } else {
        ServexUtils.showSnackbar(
          SnackType.error,
          response?.data['detail'] ?? 'Invalid or expired OTP.',
        );
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
    }
  }

  Future<void> _verifyLoginOtp(String email) async {
    try {
      final response = await _apiService.verifyLoginOtp(email: email, otp: otp);

      if (response?.statusCode == 200) {
        final data = response!.data;
        final token = data['access_token'];
        final message = data['message'] ?? 'Login successful!';

        if (token != null) {
          await _saveUserSession(data);
          await _localStorage.setToken(token);
        }

        ServexUtils.showSnackbar(SnackType.success, message);
        Get.offAllNamed(Routes.mainScreen);
      } else {
        ServexUtils.showSnackbar(
          SnackType.error,
          response?.data['detail'] ?? 'Invalid or expired OTP.',
        );
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
    }
  }

  Future<void> resendOtp(String email, String flowType) async {
    isResending.value = true;
    ServexUtils.showLoader();

    try {
      Response? response;

      if (flowType == 'register') {
        response = await _apiService.resendRegistrationOtp(email);
      } else if (flowType == 'login') {
        response = await _apiService.resendLoginOtp(email);
      } else {
        ServexUtils.showSnackbar(
          SnackType.error,
          'Unknown flow type for resend.',
        );
        return;
      }

      if (response?.statusCode == 200) {
        ServexUtils.showSnackbar(
          SnackType.success,
          'A new OTP has been sent to your email.',
        );
      } else {
        ServexUtils.showSnackbar(
          SnackType.error,
          response?.data['detail'] ?? 'Failed to resend OTP.',
        );
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
    } finally {
      isResending.value = false;
      ServexUtils.hideLoader();
    }
  }

  Future<void> _saveUserSession(Map<String, dynamic> responseData) async {
    await _localStorage.setToken(responseData['access_token']);
    await _localStorage.setUserID(responseData['user']['id']);

    final user = responseData['user'];
    await _localStorage.setUserDetails(
      UserCachedModel(
        id: user['id'],
        fullName: user['name'],
        email: user['email'],
        mobile: user['mobile'],
        address: user['address'],
        image: user['image'],
      ),
    );
  }

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}

import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/data/models/user_cached_model.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/services/auth_api_service.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';

class VerifyOtpController extends GetxController {
  final otpControllers = List.generate(6, (_) => TextEditingController());
  final isLoading = false.obs;
  final isResending = false.obs;

  final AuthApiService _apiService = AuthApiService();
  final LocalStorage _localStorage = LocalStorage();

  String get otp => otpControllers.map((controller) => controller.text).join();

  Future<void> handleOtpVerification(String email, String flowType) async {
    if (otp.length < 6) {
      Get.snackbar(
        'Invalid',
        'Please enter complete 6-digit OTP',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      if (flowType == 'register') {
        await verifyRegisterOtp(email);
      } else if (flowType == 'login') {
        await verifyLoginOtp(email);
      } else {
        Get.snackbar(
          'Error',
          'Unknown flow type',
          backgroundColor: AppColors.errorColor,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Unexpected error: $e',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyRegisterOtp(String email) async {
    try {
      final response = await _apiService.verifyRegistrationOtp(
        email: email,
        otp: otp,
      );

      if (response.statusCode == 200) {
        // await _saveUserSession(response.data);
        Get.snackbar(
          'Success',
          'Registration successful!',
          backgroundColor: AppColors.successColor,
          colorText: Colors.white,
        );
        Get.offAllNamed(Routes.mainScreen);
      } else {
        Get.snackbar(
          'Invalid OTP',
          response.data['detail'] ?? 'Invalid or expired OTP.',
          backgroundColor: AppColors.errorColor,
          colorText: Colors.white,
        );
      }
    } on DioException catch (e) {
      Get.snackbar(
        'Network Error',
        e.response?.data['detail'] ?? 'Failed to verify registration OTP.',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
    }
  }

  Future<void> verifyLoginOtp(String email) async {
    try {
      final response = await _apiService.verifyLoginOtp(email: email, otp: otp);

      if (response.statusCode == 200) {
        await _saveUserSession(response.data);

        final data = response.data;
        final token = data['access_token'];
        final msg = data['message'] ?? 'Login successfully!';
        if (token != null) {
          await _localStorage.setToken(token);
        }
        Get.snackbar(
          'Success',
          msg,
          backgroundColor: AppColors.successColor,
          colorText: Colors.white,
        );

        Get.offAllNamed(Routes.mainScreen);
      } else {
        Get.snackbar(
          'Invalid OTP',
          response.data['detail'] ?? 'Invalid or expired OTP.',
          backgroundColor: AppColors.errorColor,
          colorText: Colors.white,
        );
      }
    } on DioException catch (e) {
      print('errrrr $e');
      Get.snackbar(
        'Network Error',
        e.response?.data['detail'] ?? 'Failed to verify login OTP.',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
    }
  }

  /// ✅ RESEND OTP handler for both 'register' and 'login'
  Future<void> resendOtp(String email, String flowType) async {
    isResending.value = true;

    try {
      Response response;

      if (flowType == 'register') {
        response = await _apiService.resendRegistrationOtp(email);
      } else if (flowType == 'login') {
        response = await _apiService.resendLoginOtp(email);
      } else {
        Get.snackbar(
          'Error',
          'Unknown flow type for resend.',
          backgroundColor: AppColors.errorColor,
          colorText: Colors.white,
        );
        return;
      }

      if (response.statusCode == 200) {
        Get.snackbar(
          'OTP Sent',
          'A new OTP has been sent to your email.',
          backgroundColor: AppColors.successColor,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Failed',
          response.data['detail'] ?? 'Failed to resend OTP.',
          backgroundColor: AppColors.errorColor,
          colorText: Colors.white,
        );
      }
    } on DioException catch (e) {
      Get.snackbar(
        'Network Error',
        e.response?.data['detail'] ?? 'Failed to resend OTP.',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
    } finally {
      isResending.value = false;
    }
  }

  Future<void> _saveUserSession(Map<String, dynamic> responseData) async {
    await _localStorage.setToken(responseData['access_token']);

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

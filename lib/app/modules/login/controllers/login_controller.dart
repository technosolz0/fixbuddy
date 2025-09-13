import 'package:dio/dio.dart';
import 'package:fixbuddy/app/constants/custom_overlay.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/services/auth_api_service.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:fixbuddy/app/utils/servex_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;

  final AuthApiService _apiService = AuthApiService();
  final LocalStorage _localStorage = LocalStorage();

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> sendOtp() async {
    final email = emailController.text.toLowerCase().trim();

    if (email.isEmpty || !isValidEmail(email)) {
      ServexUtils.showSnackbar(
        SnackType.error,
        email.isEmpty
            ? 'Please enter your email'
            : 'Enter a valid email address',
      );
      return;
    }

    isLoading.value = true;
    // ServexUtils.showLoader();

    try {
      final response = await _apiService.sendLoginOtp(email);

      if (response?.statusCode == 200) {
        ServexUtils.showSnackbar(SnackType.success, 'OTP sent to your email');

        Get.toNamed(
          Routes.verifyOtp,
          arguments: {'email': email, 'flowType': 'login'},
        );
      } else {
        ServexUtils.showSnackbar(
          SnackType.error,
          response?.data['message'] ?? 'Failed to send OTP',
        );
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
    } catch (e) {
      ServexUtils.showSnackbar(SnackType.error, 'Unexpected error: $e');
    } finally {
      isLoading.value = false;
      ServexUtils.hideLoader();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> logout() async {
    await _localStorage.clearLocalStorage();

    Get.offAllNamed(Routes.login);
    ServexUtils.showSnackbar(
      SnackType.info,
      'You have been logged out successfully.',
    );
  }
}

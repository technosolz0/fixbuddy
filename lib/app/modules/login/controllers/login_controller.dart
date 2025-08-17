import 'package:dio/dio.dart';
import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/services/auth_api_service.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();

  final LocalStorage _localStorage = LocalStorage();
  final isLoading = false.obs;

  final AuthApiService _apiService = AuthApiService();

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> sendOtp() async {
    final email = emailController.text.trim();

    if (email.isEmpty || !isValidEmail(email)) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Invalid Input',
        email.isEmpty
            ? 'Please enter your email'
            : 'Enter a valid email address',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      final response = await _apiService.sendLoginOtp(email);

      if (response.statusCode == 200) {
        Get.closeAllSnackbars();
        Get.snackbar(
          'Success',
          'OTP sent to your email',
          backgroundColor: AppColors.successColor,
          colorText: Colors.white,
        );
        Get.toNamed(
          Routes.verifyOtp,
          arguments: {'email': email, 'flowType': 'login'},
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to send OTP',
          backgroundColor: AppColors.errorColor,
          colorText: Colors.white,
        );
      }
    } on DioError catch (e) {
      Get.snackbar(
        'Error',
        e.response?.data['detail'] ?? 'Something went wrong',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
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

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> logout() async {
    await _localStorage.clearLocalStorage();

    Get.offAllNamed(Routes.login);
    Get.snackbar(
      'Logged out',
      'You have been logged out successfully.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

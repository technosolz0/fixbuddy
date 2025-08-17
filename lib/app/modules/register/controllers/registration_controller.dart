import 'package:dio/dio.dart';
import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/services/auth_api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();

  final isLoading = false.obs;
  final AuthApiService _apiService = AuthApiService();

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> registerUser() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final mobile = mobileController.text.trim();

    if (name.isEmpty || email.isEmpty || mobile.isEmpty) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Missing Fields',
        'Please fill in all details',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
      return;
    }

    if (!isValidEmail(email)) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Invalid Email',
        'Enter a valid email address',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      final response = await _apiService.sendRegistrationOtp(
        name: name,
        email: email,
        mobile: mobile,
      );

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
          arguments: {'email': email, 'flowType': 'register'},
        );
      } else {
        Get.snackbar(
          'Error',
          'Registration failed',
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
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    super.onClose();
  }
}

import 'package:dio/dio.dart';
import 'package:fixbuddy/app/constants/custom_overlay.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/services/auth_api_service.dart';
import 'package:fixbuddy/app/utils/servex_utils.dart';
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
    final email = emailController.text.trim().toLowerCase();
    final mobile = mobileController.text.trim();

    if (name.isEmpty || email.isEmpty || mobile.isEmpty) {
      ServexUtils.showSnackbar(SnackType.error, 'Please fill in all details');
      return;
    }

    if (!isValidEmail(email)) {
      ServexUtils.showSnackbar(SnackType.error, 'Enter a valid email address');
      return;
    }

    isLoading.value = true;
    ServexUtils.showLoader();

    try {
      final response = await _apiService.sendRegistrationOtp(
        name: name,
        email: email,
        mobile: mobile,
      );

      if (response?.statusCode == 200) {
        ServexUtils.showSnackbar(SnackType.success, 'OTP sent to your email');

        Get.toNamed(
          Routes.verifyOtp,
          arguments: {'email': email, 'flowType': 'register'},
        );
      } else {
        ServexUtils.showSnackbar(
          SnackType.error,
          response?.data['detail'] ?? 'Registration failed',
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
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    super.onClose();
  }
}

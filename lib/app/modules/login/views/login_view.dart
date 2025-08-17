import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/utils/extensions.dart';
import 'package:fixbuddy/app/widgets/custom_app_bar.dart';
import 'package:fixbuddy/app/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Login',
        centerTitle: true,
        leadingIcon: null,
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * 0.35,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.secondaryColor,
                  AppColors.tritoryColor,
                  AppColors.whiteColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  // Center(
                  //   child: Image.asset(
                  //     'assets/icons/login_illustration.png',
                  //     height: 160,
                  //   ),
                  // ),
                  const SizedBox(height: 30),
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Login to continue booking your services.',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Email Address',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: AppColors.blackColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: AppColors
                          .blackColor, // 👈 change this to your desired color
                      fontSize: 16, // optional
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your email',

                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: AppColors.primaryColor,
                      ),
                      filled: true,
                      fillColor: AppColors.whiteColor,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 16,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.sendOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          foregroundColor: Colors.black,
                        ),
                        child: controller.isLoading.value
                            ? CircularProgressIndicator(
                                color: context.isLightTheme
                                    ? AppColors.blackColor
                                    : AppColors.whiteColor,
                              )
                            : const Text(
                                'Send OTP',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: Row(
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: TextStyle(
                            color: context.isLightTheme
                                ? AppColors.blackColor
                                : AppColors.whiteColor,
                          ),
                        ),
                        CustomTextButton(
                          label: 'Register',
                          onPressed: () => Get.toNamed(Routes.register),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

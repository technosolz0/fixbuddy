import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/modules/register/views/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/registration_controller.dart';

class RegistrationView extends StatelessWidget {
  final RegistrationController controller = Get.put(RegistrationController());

  RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          // Top gradient
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
                  const SizedBox(height: 30),
                  // Center(
                  //   child: Image.asset(
                  //     'assets/icons/register_illustration.png',
                  //     height: 160,
                  //   ),
                  // ),
                  const SizedBox(height: 24),
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Register to book and manage your services easily.',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  const SizedBox(height: 30),

                  // Name Field
                  CustomTextField(
                    controller: controller.nameController,
                    label: 'Full Name',
                  ),
                  const SizedBox(height: 16),

                  // Email Field
                  CustomTextField(
                    controller: controller.emailController,
                    label: 'Email',
                    inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // Mobile Field
                  CustomTextField(
                    controller: controller.mobileController,
                    label: 'Mobile',
                    inputType: TextInputType.phone,
                  ),
                  const SizedBox(height: 32),

                  // Submit Button
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.registerUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          foregroundColor: Colors.black,
                        ),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.black,
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

                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: const Text(
                        'Back to Login',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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

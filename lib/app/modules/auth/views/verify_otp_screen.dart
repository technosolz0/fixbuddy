import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/modules/auth/controllers/verify_otp_controller.dart';
import 'package:fixbuddy/app/utils/extensions.dart';
import 'package:fixbuddy/app/widgets/custom_app_bar.dart';
import 'package:fixbuddy/app/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpView extends StatelessWidget {
  OtpView({super.key});

  final VerifyOtpController controller = Get.put(VerifyOtpController());

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final email = args['email'] ?? '';
    final flowType = args['flowType'] ?? 'register';

    return 
    Scaffold(
      appBar: const CustomAppBar(title: 'Enter OTP', centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Text(
              'Enter the 6-digit OTP sent to $email',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: context.isLightTheme
                    ? AppColors.blackColor
                    : AppColors.whiteColor,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 50,
                  height: 60,
                  child: TextField(
                    controller: controller.otpControllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: const TextStyle(fontSize: 22),
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: AppColors.whiteColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 40),
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.handleOtpVerification(email, flowType),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    foregroundColor: Colors.black,
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.black)
                      : Text(
                          'Verify OTP',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomTextButton(
              label: 'resend',
              onPressed: () {
                controller.resendOtp(email, flowType);
              },
            ),
          ],
        ),
      ),
    );
  }
}

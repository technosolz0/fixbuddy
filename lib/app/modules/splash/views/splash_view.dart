import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/modules/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  final SplashController controller = Get.put(SplashController());

  SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace with your logo or icon
            const Icon(Icons.build_circle_rounded, color: Colors.white, size: 90),
            const SizedBox(height: 20),
            const Text(
              "FixBuddy",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const CircularProgressIndicator(color: Colors.white)
          ],
        ),
      ),
    );
  }
}

import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/modules/splash/controllers/splash_controller.dart';
import 'package:fixbuddy/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class OnboardView extends StatelessWidget {
  OnboardView({super.key});

  SplashController splashController = Get.find<SplashController>();

  PageController onboardPageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              SizedBox(height: 22.h),
              Expanded(
                child: PageView.builder(
                  onPageChanged: (value) {
                    splashController.currentOnboardIndex.value = value;
                  },
                  physics: const BouncingScrollPhysics(),
                  controller: onboardPageController,
                  itemCount: splashController.onboardData.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> currentData =
                        splashController.onboardData[index];
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                currentData['subtitle'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.blackColor.withAlpha(
                                    (0.74 * 255).round(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                currentData['title'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.blackColor,
                                ),
                              ),
                              SizedBox(height: 12.h),
                            ],
                          ),
                          Image.asset(
                            currentData['image'],
                            width: 0.7.sw,
                            fit: BoxFit.fitWidth,
                          ),
                          Text(
                            currentData['text'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 36.h),
              dotIndicators(splashController.currentOnboardIndex.value),
              SizedBox(height: 34.h),
              CustomButton(
                onPressed: () {
                  if (splashController.currentOnboardIndex.value ==
                      splashController.onboardData.length - 1) {
                    splashController.completeOnboarding();
                    return;
                  }
                  splashController.currentOnboardIndex.value += 1;
                  onboardPageController.animateToPage(
                    splashController.currentOnboardIndex.value,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                text:
                    splashController.currentOnboardIndex.value ==
                        splashController.onboardData.length - 1
                    ? 'Get started'
                    : 'Next',
                wrap: true,
              ),
              if (splashController.currentOnboardIndex.value !=
                  splashController.onboardData.length - 1)
                Column(
                  children: [
                    SizedBox(height: 16.h),
                    TextButton(
                      onPressed: () {
                        onboardPageController.animateToPage(
                          splashController.onboardData.length - 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height:
                    splashController.currentOnboardIndex.value !=
                        splashController.onboardData.length - 1
                    ? 30.h
                    : 95.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dotIndicators(int currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(splashController.onboardData.length, (index) {
          return Container(
            margin: const EdgeInsets.only(right: 6),
            width: index == currentIndex ? 30.w : 8.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: index == currentIndex
                  ? AppColors.primaryColor
                  : AppColors.grayColor,
              borderRadius: BorderRadius.circular(20),
            ),
          );
        }),
      ],
    );
  }
}

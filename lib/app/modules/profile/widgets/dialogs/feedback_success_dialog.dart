import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void showFeedbackSuccessDialog() {
  showDialog(
      context: Get.context!,
      builder: (_) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16.r)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image.asset(
                //   AssetsConstants.surveyThanks,
                //   width: 40.w,
                //   height: 40.h,
                // ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "Thank you",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                      fontSize: 22.sp),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  'Thanks for providing your valuable feedback with us',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor,
                      fontSize: 16.sp),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                  onPressed: () {
                    Get.back();
                  },
                  text: "Okay",
                ),
              ],
            ),
          ),
        );
      });
}

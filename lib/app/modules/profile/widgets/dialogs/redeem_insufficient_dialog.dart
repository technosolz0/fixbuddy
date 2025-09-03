import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future showInsufficientPointsDialog() async {
  await showDialog(
    context: Get.context!,
    builder: (_) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.currency_bitcoin),
                  // Image.asset(
                  //   AssetsConstants.coin,
                  //   width: 20.w,
                  //   height: 20.h,
                  // ),
                  SizedBox(width: 10.w),
                  Text(
                    "Insufficient Points",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // color: ThemeClass.ffda5848,
                      fontSize: 22.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              Text(
                'You do not have sufficient points to redeem this reward.',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 16.h),
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
    },
  );
}

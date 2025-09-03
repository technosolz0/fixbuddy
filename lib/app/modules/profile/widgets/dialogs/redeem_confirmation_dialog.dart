import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future showRedeemConfirmationDialog({required VoidCallback onTapYes}) async {
  await showDialog(
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
                Row(
                  children: [
                    // Image.asset(
                    //   AssetsConstants.coin,
                    //   width: 20.w,
                    //   height: 20.h,
                    // ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "Redeem Now",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 22.sp),
                    ),
                  ],
                ),
                SizedBox(
                  height: 18.h,
                ),
                Text(
                  'Are you sure you want to redeem this reward?',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor,
                      fontSize: 16.sp),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 140.h,
                      child: CustomButton(
                        onPressed: () {
                          Get.back();
                        },
                        text: "Cancel",
                        textColor: AppColors.blackColor,
                        // bgColor: AppColors.ffe1e9eb,
                      ),
                    ),
                    SizedBox(
                      width: 140.h,
                      child: CustomButton(
                        onPressed: () {
                          Get.back();
                          onTapYes();
                        },
                        text: "Yes",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

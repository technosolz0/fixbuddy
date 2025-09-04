import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future updateReadyForInstallation(VoidCallback onInstall) {
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(28.r),
        topRight: Radius.circular(28.r),
      ),
    ),
    backgroundColor: AppColors.whiteColor,
    elevation: 0,
    context: Get.context!,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Wrap(
          children: [
            SizedBox(height: 20.h),
            Text(
              'App ready for installation.',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
              ),
            ),
            SizedBox(height: 40.h),
            CustomButton(onPressed: onInstall, text: "Install"),
          ],
        ),
      );
    },
  );
}

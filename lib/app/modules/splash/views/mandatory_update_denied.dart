import 'package:fixbuddy/app/utils/servex_utils.dart';
import 'package:fixbuddy/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MandatoryUpdateDenied extends StatelessWidget {
  const MandatoryUpdateDenied({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Update Denied",
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              const Text(
                "You are required to update this app to continue using it!",
              ),
              SizedBox(height: 20.h),
              CustomButton(
                onPressed: () {
                  Get.back();
                  ServexUtils.checkForUpdate();
                },
                text: 'Update',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

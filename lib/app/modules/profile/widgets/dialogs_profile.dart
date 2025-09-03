import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/modules/settings/controllers/setting_controller.dart';
import 'package:fixbuddy/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

showRateDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 30.sp),
                    // Image.asset(AssetsConstants.star, height: 20.h),
                    SizedBox(width: 10.w),
                    Text(
                      "Rate Your Experience",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Text(
                    "Recommend us to others by rating us on Play store",
                    style: TextStyle(fontSize: 16.sp, color: Colors.black),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 140.w,
                      child: CustomButton(
                        onPressed: () {
                          Get.back();
                        },
                        text: "Not Now",
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 140.w,
                      child: CustomButton(
                        onPressed: () {
                          Get.find<SettingController>().rateInPlayStore();
                        },
                        text: "Rate us",
                        // textStyle:
                        //     TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

showDeleteAccountDialog(
  BuildContext context,
  SettingController controller,
  int type,
) {
  showDialog(
    context: context,
    barrierDismissible: controller.loading.value ? false : true,
    builder: (_) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Image.asset(
                    //   AssetsConstants.delete,
                    //   height: 20.h,
                    // ),
                    Icon(Icons.delete, size: 20.h, color: Colors.red),
                    SizedBox(width: 10.w),
                    Text(
                      "Delete Account",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Text(
                    type == 1
                        ? "By deleting your account, you will lose access to all your saved content and features"
                        : "This action cannot be undone. Delete account permanently?",
                    style: TextStyle(fontSize: 16.sp, color: Colors.black),
                  ),
                ),
                Visibility(
                  visible: type != 1,
                  child: Column(
                    children: [
                      // CustomTextformField(
                      //   maxL: 3,
                      //   controller: controller.accountDeletionReasonController,
                      //   name: 'Reason',
                      // ),

                      TextFormField(
                        controller: controller.accountDeletionReasonController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Reason",
                          hintStyle: const TextStyle(color: AppColors.grayColor),
                          filled: true,
                          fillColor: AppColors.lightGrayColor,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        )),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 140.w,
                      child: CustomButton(
                        onPressed: () {
                          Get.back();
                        },
                        text: "Cancel",
                      ),
                    ),
                    const Spacer(),
                    // SizedBox(
                    //   width: 140.w,
                    //   child: Obx(
                    //     () => CustomButton(
                    //       onPressed: () {
                    //         if (type == 1) {
                    //           Get.back();
                    //           showDeleteAccountDialog(context, controller, 2);
                    //         } else {
                    //           controller.deleteAccountRequest();
                    //         }
                    //       },
                    //       text: controller.loading.value ? null : 'Confirm',
                    //       // textStyle:
                    //       //     TextStyle(color: Colors.white, fontSize: 16.sp),
                    //       child: controller.loading.value
                    //           ? const ButtonLoader()
                    //           : null,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

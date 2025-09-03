import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/modules/settings/controllers/setting_controller.dart';
import 'package:fixbuddy/app/utils/servex_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/theme.dart';

feedbackBottomsheet(BuildContext context) {
  SettingController controller = Get.find<SettingController>();
  controller.selectedStars.value = 0;
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(28.r),
        topRight: Radius.circular(28.r),
      ),
    ),
    backgroundColor: ThemeClass.whiteColor,
    elevation: 0,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Wrap(
          children: [
            Container(
              height: 0.03.sh,
              decoration: BoxDecoration(
                color: ThemeClass.primaryColorLight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.r),
                  topRight: Radius.circular(28.r),
                ),
              ),
              child: Center(
                child: Container(
                  width: 0.054.sh,
                  height: 0.006.sh,
                  decoration: BoxDecoration(
                    color: ThemeClass.primaryColor,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(2.r),
                      right: Radius.circular(2.r),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Feedback",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      color: ThemeClass.primaryColor,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "Rate your Experience",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.blackColor.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Obx(
                    () => Row(
                      children: [
                        ...List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () {
                              if (controller.selectedStars.value == index + 1) {
                                controller.selectedStars.value = index;
                              } else {
                                controller.selectedStars.value = index + 1;
                              }
                            },
                            child: index + 1 <= controller.selectedStars.value
                                ? Icon(
                                    Icons.star_rounded,
                                    color: ThemeClass.primaryColor,
                                    size: 55.sp,
                                  )
                                : Icon(
                                    Icons.star_border_rounded,
                                    color: ThemeClass.primaryColor,
                                    size: 55.sp,
                                  ),
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: 38.h),
                  Text(
                    "Would you like to give some feedback about the Health Parliament App ?",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.blackColor,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          // color: AppColors.shadowColor,
                          blurRadius: 5.r,
                        ),
                      ],
                    ),
                    child: TextField(
                      onTapOutside: (event) {
                        // ServexUtils.unfocusKeyboard();
                      },
                      autocorrect: false,
                      enableSuggestions: false,
                      spellCheckConfiguration:
                          const SpellCheckConfiguration.disabled(),
                      controller: controller.feedbackController,
                      maxLines: 5,
                      maxLength: 2000,
                      decoration: const InputDecoration(
                        counterText: "",
                        hintText: "Tell us how can we improve",
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 35.h),
                  // Obx(
                  //   () => CustomFilledButton(
                  //     onPressed: () {
                  //       controller.recordFeedback();
                  //     },
                  //     text: controller.loading.value ? null : 'Submit',
                  //     textStyle: TextStyle(
                  //       color: ThemeClass.whiteColor,
                  //       fontSize: 16.sp,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //     child: controller.loading.value
                  //         ? const ButtonLoader()
                  //         : null,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  ).whenComplete(() => controller.feedbackController.clear());
}

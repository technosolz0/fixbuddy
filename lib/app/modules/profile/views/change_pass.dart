import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/modules/settings/controllers/setting_controller.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/utils/servex_utils.dart';
import 'package:fixbuddy/app/widgets/custom_button.dart';
import 'package:fixbuddy/app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/validations.dart';

class ChangePassView extends StatefulWidget {
  const ChangePassView({super.key});

  @override
  State<ChangePassView> createState() => _ChangePassViewState();
}

class _ChangePassViewState extends State<ChangePassView> {
  SettingController controller = Get.find<SettingController>();

  @override
  void initState() {
    super.initState();
    // FAnalytics.logScreen(screenName: 'Change Password');
  }

  @override
  void dispose() {
    controller.confirmNewPasswordController.clear();
    controller.newPassController.clear();
    controller.currentPassController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: MediaQuery.of(context).viewInsets.bottom > 50
            ? null
            : const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: 1.sh,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        "Create a new password which should contain minimum of 8 or more characters and at least one special character (e.g., !, @, #, \$, %, etc.)",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackColor,
                        ),
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                    width: 1.sw,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                    ),
                    child: Form(
                      key: controller.createPassFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 26.h),
                          Obx(
                            () => CustomTextFormField(
                              name: 'Current Password',
                              hintText: 'Enter current password',
                              controller: controller.currentPassController,
                              obscureText:
                                  controller.obscureCurrentPassword.value,
                              suffixIcon: IconButton(
                                onPressed: controller.toggleObscurePassword,
                                icon: Icon(
                                  controller.obscureCurrentPassword.value
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                              ),
                              validator: Validator.passwordValidation,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          SizedBox(height: 26.h),
                          Obx(
                            () => CustomTextFormField(
                              name: 'New Password',
                              hintText: 'Enter new password',
                              controller: controller.newPassController,
                              obscureText: controller.obscurePassword.value,
                              suffixIcon: IconButton(
                                onPressed: controller.toggleCurrentPassword,
                                icon: Icon(
                                  controller.obscurePassword.value
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                              ),
                              validator: Validator.passwordValidation,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          SizedBox(height: 26.h),
                          Obx(
                            () => TextFormField(
                              textInputAction: TextInputAction.done,
                              onTapOutside: (val) {
                                ServexUtils.unfocusKeyboard();
                              },
                              autocorrect: false,
                              enableSuggestions: false,
                              spellCheckConfiguration:
                                  const SpellCheckConfiguration.disabled(),
                              controller:
                                  controller.confirmNewPasswordController,
                              cursorColor: AppColors.primaryColor,
                              obscureText:
                                  controller.obscureConfirmPassword.value,
                              maxLines: 1,
                              validator: (val) {
                                return Validator.passwordValidation(
                                  val,
                                  confirmPassword: controller
                                      .confirmNewPasswordController
                                      .text,
                                );
                              },
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                hintText: 'Confirm New Password',
                                label: const Text('Confirm Password'),
                                suffixIcon: IconButton(
                                  onPressed: () =>
                                      controller.toggleConfirmPassword(),
                                  icon: Icon(
                                    controller.obscureConfirmPassword.value
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                  ),
                                ),
                              ),
                              onFieldSubmitted: (val) {
                                controller.changePass();
                              },
                            ),
                          ),
                          SizedBox(height: 46.h),
                          Obx(
                            () => CustomButton(
                              text: 'Save Password',

                              onPressed: () {
                                controller.changePass();
                              },
                            ),
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.forgotPassword);
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

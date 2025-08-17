import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:fixbuddy/app/constants/app_constants.dart';
import 'package:fixbuddy/app/constants/asset_constant.dart';
import 'package:fixbuddy/app/utils/extensions.dart';
import 'package:fixbuddy/app/utils/gotham_rounded.dart';
import 'package:fixbuddy/app/widgets/custom_app_bar.dart';
import 'package:fixbuddy/app/widgets/custom_button.dart';
import 'package:fixbuddy/app/widgets/option_tile.dart';

import '../controllers/language_controller.dart';

class LanguageView extends GetView<LanguageController> {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.fromLogin) {
          return true;
        } else {
          return await controller.scheduleReminders();
        }
      },
      child: Scaffold(
        appBar: controller.fromLogin
            ? null
            : CustomAppBar(
                title: context.l10n.change_language,
                leadingIcon: Icons.arrow_back,
                onLeadingPressed: () async {
                  if (!controller.fromLogin) {
                    await controller.scheduleReminders();
                  }
                  Get.back();
                },
              ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: controller.fromLogin ? 60.h : 30.h),
                  if (controller.fromLogin) ...[
                    Hero(
                      tag: 'main-logo-splash',
                      child: Image.asset(AssetConstants.logo, width: 0.4.sw),
                    ),
                    SizedBox(height: 12.h),
                    Hero(
                      tag: 'logo-text-splash',
                      child: Image.asset(
                        context.isLightTheme
                            ? AssetConstants.logoTextDark
                            : AssetConstants.logoText,
                        width: 0.65.sw,
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                  SizedBox(
                    height: 0.13.sh,
                    child: Text(
                      context.l10n.change_lang_msg,
                      style: GothamRounded.medium(fontSize: 20.sp),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  OptionTile(
                    text: 'English',
                    isSelected:
                        context.l10n.localeName == AppLanguage.english.locale,
                    onTap: () => controller.changeAppLanguage(
                      context,
                      AppLanguage.english,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  OptionTile(
                    text: 'हिन्दी',
                    isSelected:
                        context.l10n.localeName == AppLanguage.hindi.locale,
                    onTap: () => controller.changeAppLanguage(
                      context,
                      AppLanguage.hindi,
                    ),
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: controller.fromLogin
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: CustomButton(
                  onPressed: controller.goToLogin,
                  text: context.l10n.next,
                ),
              )
            : null,
      ),
    );
  }
}

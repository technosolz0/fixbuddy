import 'package:fixbuddy/app/constants/app_constants.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:fixbuddy/app/utils/servex_utils.dart';
import 'package:fixbuddy/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  bool fromLogin = true;
  AppLanguage selectedLang = AppLanguage.english;
  bool isLanguageChanged = false;

  @override
  onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments.length > 0) {
      fromLogin = Get.arguments[0] ?? true;
    }
  }

  // To change the app's language directly on click of a language
  Future changeAppLanguage(BuildContext context, AppLanguage lang) async {
    isLanguageChanged = true;
    selectedLang = lang;
    ServexApp.setLocale(
      context,
      Locale(lang.locale),
    );
    await LocalStorage().setLanguage(lang.locale);
  }

  // To go to login screen if changing language on app start
  void goToLogin() {
    LocalStorage().setLanguage(selectedLang.locale);
    Get.offAllNamed(Routes.login);
  }

  // To schedule reminders when changing language from inside the app & not on logoin
  Future<bool> scheduleReminders() async {
    if (!isLanguageChanged) {
      return true;
    }
    ServexUtils.showOverlayLoadingDialog();

    ServexUtils.hideOverlayLoadingDialog();
    return true;
  }
}

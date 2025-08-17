import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
// import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:fixbuddy/app/constants/custom_overlay.dart';
import 'package:fixbuddy/app/data/services/auth_services.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/utils/firebase_notifications.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:fixbuddy/main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ServexUtils {
  //logout
  static Future logOut({bool showLoaders = true, bool callAPI = true}) async {
    if (showLoaders) ServexUtils.showOverlayLoadingDialog();
    //call logout api
    bool success = true;
    if (callAPI) {
      success = await AuthServices().logout();
    }
    if (success) {
      isLoggedIn = false;
      //clear notifications txt files
      await FirebaseNotifications().notificationRemover();
      //cancelling all reminders
      // await Reminders.cancelAllReminders();
      // FlutterLocalNotificationsPlugin().cancelAll();
      if (showLoaders) ServexUtils.hideOverlayLoadingDialog();
      //clear local cache
      await LocalStorage().clearLocalStorage();
      //clearing pedometer steps from shared pref

      //go to login page
      Get.offAllNamed(Routes.login);
    } else {
      if (showLoaders) ServexUtils.hideOverlayLoadingDialog();

      // ServexUtils.showSnackbar(SnackType.ERROR,
      //     '${Get.context!.l10n.cannot_logout}, ${Get.context!.l10n.something_went_wrong}');
    }
  }

  static void hideCurrentSnackbar() {
    ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
  }

  static void showSnackbar(SnackType type, String message) {
    hideCurrentSnackbar();
    CustomSnackbar.show(
      context: Get.overlayContext!,
      message: message,
      type: type,
    );
  }

  static dPrint(var data) {
    if (kDebugMode) {
      print(data);
    }
  }

  /// To log on console only for debug mode
  static dLog(var data) {
    if (kDebugMode) {
      log(data.toString());
    }
  }

  // To change the app's theme
  Future changeAppThemeMode(BuildContext context, ThemeMode theme) async {
    // ServexApp.setThemeMode(context, theme);
    // await LocalStorage().setIsDarkMode(theme.isDarkTheme);
  }

  /// Debug console log
  static void logPrint(dynamic data) {
    if (kDebugMode) log(data.toString());
  }

  /// Show toast message
  static void showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }

  /// Show overlay loader
  static void showLoader() {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  /// Hide overlay loader
  static void hideLoader() {
    if (Get.isDialogOpen!) Get.back();
  }

  /// Pick image from camera or gallery
  static Future<File?> pickImage(ImageSource source) async {
    try {
      final picked = await ImagePicker().pickImage(source: source);
      return picked != null ? File(picked.path) : null;
    } catch (e) {
      logPrint('Image pick error: $e');
      return null;
    }
  }

  /// Crop an image file
  // static Future<File?> cropImage(File imageFile) async {
  //   try {
  //     CroppedFile? cropped = await ImageCropper().cropImage(
  //       sourcePath: imageFile.path,
  //       uiSettings: [
  //         AndroidUiSettings(
  //           toolbarTitle: 'Crop Image',
  //           toolbarWidgetColor: Colors.white,
  //           toolbarColor: Colors.black,
  //           lockAspectRatio: false,
  //         ),
  //         IOSUiSettings(title: 'Crop Image'),
  //       ],
  //     );
  //     return cropped != null ? File(cropped.path) : null;
  //   } catch (e) {
  //     logPrint('Image crop error: $e');
  //     return null;
  //   }
  // }

  /// Launch URL in external browser
  static Future<bool> launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: LaunchMode.externalApplication);
      return true;
    }
    return false;
  }

  /// Get app version string
  static Future<String> getAppVersion() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    return info.version;
  }

  /// Android-only: Check for in-app update availability and prompt
  static Future checkForAppUpdate() async {
    if (!Platform.isAndroid) return;
    try {
      final updateInfo = await InAppUpdate.checkForUpdate();
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        InAppUpdate.performImmediateUpdate();
      }
    } catch (e) {
      logPrint('Update check failed: $e');
    }
  }

  /// Share plain text
  static void shareText(String text) {
    Share.share(text);
  }

  static showOverlayLoadingDialog() {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      // ignore: deprecated_member_use
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: SizedBox(
            width: 60.w,
            height: 60.w,
            child: Text('data'),

            // Image.asset(
            //   AssetConstants.logo,
            //   width: 60.w,
            //   height: 60.w,
            // )
            //     .animate(
            //       onPlay: (controller) => controller.repeat(),
            //     )
            //     .rotate(begin: -1, duration: const Duration(seconds: 1)),
          ),
        ),
      ),
    );
  }

  /// To hide a currently displayed overlay loading dialog
  static hideOverlayLoadingDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
}

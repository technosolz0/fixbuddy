import 'package:fixbuddy/app/constants/custom_overlay.dart';
import 'package:fixbuddy/app/modules/profile/services/setting_services.dart';
import 'package:fixbuddy/app/modules/profile/widgets/dialogs/feedback_success_dialog.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/utils/firebase_notifications.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:fixbuddy/app/utils/servex_utils.dart';
import 'package:fixbuddy/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingController extends GetxController {
  final forgoPassFormKey = GlobalKey<FormState>();
  final createPassFormKey = GlobalKey<FormState>();
  RxString appVersion = ''.obs;

  RxBool loading = false.obs;

  RxBool obscurePassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;
  RxBool obscureCurrentPassword = true.obs;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  RxInt selectedStars = 0.obs;
  TextEditingController accountDeletionReasonController =
      TextEditingController();
  @override
  void onClose() {
    newPasswordController.dispose();
    emailController.dispose();
    confirmNewPasswordController.dispose();
    currentPassController.dispose();
    newPassController.dispose();
    confirmPassController.dispose();
    super.onClose();
  }

  @override
  void onInit() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = packageInfo.version;
    super.onInit();
  }

  void logOut() async {
    ServexUtils.showOverlayLoadingDialog();
    //call logout api
    // bool success = await UserServices().logoutUser();
    bool success = true;
    if (success) {
      //clear local cache
      await LocalStorage().clearLocalStorage();
      isLoggedIn = false;
      // await appEngagement.saveEngagementActivityTime();
      //clear notifications txt files
      await FirebaseNotifications().notificationRemover();
      ServexUtils.hideOverlayLoadingDialog();
      //go to login page
      Get.offAllNamed(Routes.login);
      // ignore: dead_code
    } else {}
  }

  void toggleObscurePassword() {
    obscureCurrentPassword.value = !obscureCurrentPassword.value;
  }

  void toggleCurrentPassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPassword() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  void goToChangePass() {
    // Get.to(() => const ChangePassView());
  }

  void goToHelpCenter() {
    // Get.to(() => const HelpCenter());
  }

  void recordFeedback() async {
    if (loading.value) {
      return;
    }
    if (selectedStars.value == 0.0) {
      ServexUtils.showSnackbar(
        "Required" as SnackType,
        "Please select a rating.",
      );
      return;
    }
    loading.value = true;
    int? id = await LocalStorage().getUserID() ?? 0;
    if (feedbackController.text.isNotEmpty) {
      await SettingServices.sendFeedBack(
        id as String,
        feedbackController.text,
        selectedStars.value,
      );
      showFeedbackSuccessDialog();
    }
    loading.value = false;
  }

  void deleteAccountRequest() async {
    if (accountDeletionReasonController.text.trim().isEmpty) {
      ServexUtils.showSnackbar("Alert" as SnackType, "Reason is required!");
      return;
    }
    loading.value = true;
    int? id = await LocalStorage().getUserID() ?? 0;
    if (id != 0) {
      await SettingServices.requestAccountDeletion(
        id as String,
        accountDeletionReasonController.text.trim(),
      );
    }
    loading.value = false;
  }

  void rateInPlayStore() async {
    Get.back();
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
    return;
  }

  void changePass() async {
    loading.value = true;
    int? id = await LocalStorage().getUserID() ?? 0;
    if (id != 0) {
      if (createPassFormKey.currentState!.validate()) {
        if (confirmNewPasswordController.text == newPassController.text) {
          await SettingServices.updatePassword(
            id as String,
            currentPassController.text,
            confirmNewPasswordController.text,
          );
        } else {
          ServexUtils.showSnackbar(
            "Alert" as SnackType,
            "Password didn't match. Try again",
          );
        }
      }
    }
    loading.value = false;
  }
}

import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  var appVersion = '1.0.0'.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch user data or app version from API/storage later
    print('SettingController initialized');
  }

  @override
  void onReady() {
    super.onReady();
    print('SettingView rendered');
  }

  @override
  void onClose() {
    print('SettingController closed');
    super.onClose();
  }

  void goToChangePass() {
    print('Navigating to Change Password');
    // Navigate to change password screen (add route if available)
    // Get.toNamed(Routes.changePassword);
  }

  void goToHelpCenter() {
    print('Navigating to Help Center');
    // Navigate to help center screen (add route if available)
    // Get.toNamed(Routes.helpCenter);
  }

  void referFriend() {
    print('Refer a Friend tapped');
    // Implement referral logic (e.g., share link, navigate to referral screen)
    // Get.toNamed(Routes.referFriend);
  }

  void logOut() {
    print('Logging out');
    Get.offAllNamed(Routes.login); // Clear stack and navigate to login
  }
}

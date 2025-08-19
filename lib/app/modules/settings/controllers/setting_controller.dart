import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  var appVersion = '1.0.0'.obs;

  final LocalStorage _localStorage = LocalStorage();
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

  Future<void> logout() async {
    await _localStorage.clearLocalStorage();

    Get.offAllNamed(Routes.login);
    Get.snackbar(
      'Logged out',
      'You have been logged out successfully.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

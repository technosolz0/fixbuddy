// import 'package:fixbuddy/app/routes/app_routes.dart';
// import 'package:fixbuddy/app/utils/local_storage.dart';
// import 'package:get/get.dart';

// class SplashController extends GetxController {
//   final LocalStorage _localStorage = LocalStorage();

//   @override
//   void onReady() {
//     super.onReady();
//     _checkUserSession();
//   }

//   Future<void> _checkUserSession() async {
//     await Future.delayed(const Duration(seconds: 2)); // for splash delay

//     final token = await _localStorage.getToken();

//     if (token != null && token.isNotEmpty) {
//       Get.offAllNamed(Routes.mainScreen);
//     } else {
//       Get.offAllNamed(Routes.login);
//     }
//   }
// }

import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:fixbuddy/app/utils/servex_utils.dart';
// import 'package:fixbuddy/app/views/onboard/onboard_view.dart'; // Create this util if needed
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final LocalStorage _localStorage = LocalStorage();
  RxInt currentOnboardIndex = 0.obs;

  final List<Map<String, dynamic>> onboardData = [
    {
      'title': 'Welcome to FixBuddy',
      'subtitle': 'Your one-stop solution for all home services.',
      'image': 'assets/images/onboard1.png',
      'text': 'Book, manage and track your services hassle-free.',
    },
    {
      'title': 'Trusted Professionals',
      'subtitle': 'Verified experts at your service.',
      'image': 'assets/images/onboard2.png',
      'text': 'We ensure quality service and safety for your home.',
    },
    {
      'title': 'Instant Booking',
      'subtitle': 'Book services in just a few taps.',
      'image': 'assets/images/onboard3.png',
      'text': 'Fast, reliable, and at your convenience.',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  Future<void> firstRunCleanup() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('first_run') ?? true) {
      await _localStorage.clearLocalStorage();
      // Optionally clean notifications or other app state
      prefs.setBool('first_run', false);
    }
  }

  Future<void> loadUser() async {
    await firstRunCleanup();
    await Future.delayed(const Duration(seconds: 2)); // Splash screen delay

    final bool isOnboarded = await _localStorage.getUserOboarded();
    final String? token = await _localStorage.getToken();
    final int registrationStatus = await _localStorage.getRegistrationStatus();
    final String lastRegisteredDateStr = await _localStorage
        .getLastRegisteredDate();

    final DateTime lastRegisteredDate =
        DateTime.tryParse(lastRegisteredDateStr) ?? DateTime(2001, 1, 1);
    final int daysSinceLastReg = DateTime.now()
        .difference(lastRegisteredDate)
        .inDays;

    if (!isOnboarded) {
      // Get.offAll(() => const OnboardView());
    } else if (registrationStatus != 4 &&
        daysSinceLastReg > 7 &&
        lastRegisteredDateStr != '2001-01-01 00:00:00.000') {
      // Reset if too old
      await _localStorage.clearLocalStorage();
      Get.offAllNamed(Routes.login);
    } else if (registrationStatus != 4 && daysSinceLastReg <= 7) {
      // Resume registration if left in middle
      Get.offAllNamed(Routes.register, arguments: registrationStatus);
    } else if (token == null || token.isEmpty) {
      Get.offAllNamed(Routes.login);
    } else {
      // Everything good, move to main screen
      Get.offAllNamed(Routes.mainScreen);
    }

    ServexUtils.checkForUpdate();
  }

  Future<void> completeOnboarding() async {
    ServexUtils.showOverlayLoadingDialog();
    await _localStorage.setUserOnboarded(true);
    ServexUtils.hideOverlayLoadingDialog();
    Get.offAllNamed(Routes.login);
  }
}

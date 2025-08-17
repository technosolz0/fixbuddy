import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final LocalStorage _localStorage = LocalStorage();

  @override
  void onReady() {
    super.onReady();
    _checkUserSession();
  }

  Future<void> _checkUserSession() async {
    await Future.delayed(const Duration(seconds: 2)); // for splash delay

    final token = await _localStorage.getToken();

    if (token != null && token.isNotEmpty) {
      Get.offAllNamed(Routes.mainScreen);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }
}

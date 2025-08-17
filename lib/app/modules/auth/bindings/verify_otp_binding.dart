import 'package:fixbuddy/app/modules/auth/controllers/verify_otp_controller.dart';
import 'package:get/get.dart';

class VerifyOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyOtpController>(() => VerifyOtpController());
  }
}

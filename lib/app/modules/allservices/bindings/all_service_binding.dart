import 'package:get/get.dart';

import '../controllers/all_service_controller.dart';

class AllServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllServicesController>(
      () => AllServicesController(),
    );
  }
}


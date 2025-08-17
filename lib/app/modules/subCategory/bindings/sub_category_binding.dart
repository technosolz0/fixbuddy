import 'package:get/get.dart';

import '../controllers/sub_category_controller.dart';

class SubCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubcategoryController>(() => SubcategoryController());
  }
}

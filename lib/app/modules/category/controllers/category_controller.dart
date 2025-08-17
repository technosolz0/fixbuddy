import 'package:fixbuddy/app/modules/category/services/category_service.dart';
import 'package:get/get.dart';
import 'package:fixbuddy/app/modules/category/models/category_model.dart';

class CategoryController extends GetxController {
  final CategoryApiService _apiService = CategoryApiService();

  var categories = <CategoryModel>[].obs;
  var filteredCategories = <CategoryModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryData();
  }

  Future<void> fetchCategoryData() async {
    try {
      isLoading.value = true;
      final result = await _apiService.fetchCategories();
      categories.assignAll(result);
      filteredCategories.assignAll(result); 
    } catch (e) {
      Get.snackbar('Error', 'Failed to load categories');
    } finally {
      isLoading.value = false;
    }
  }

  void searchCategory(String query) {
    if (query.isEmpty) {
      filteredCategories.assignAll(categories);
    } else {
      filteredCategories.assignAll(
        categories.where(
          (cat) => cat.name.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }
}

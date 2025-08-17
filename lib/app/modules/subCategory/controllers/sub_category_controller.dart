import 'package:get/get.dart';
import 'package:fixbuddy/app/modules/subCategory/models/subcategory_model.dart';
import 'package:fixbuddy/app/modules/subCategory/services/subcategory_service.dart';

class SubcategoryController extends GetxController {
  final SubcategoryApiService _apiService = SubcategoryApiService();

  var subcategories = <SubcategoryModel>[].obs;
  var filteredSubcategories = <SubcategoryModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubcategories(); // Default: load all
  }

  /// Fetch all subcategories
  Future<void> fetchSubcategories() async {
    try {
      isLoading.value = true;
      final result = await _apiService.fetchSubcategories();
      subcategories.assignAll(result);
      filteredSubcategories.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load subcategories');
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch subcategories by category ID
  Future<void> fetchByCategory(int categoryId) async {
    try {
      isLoading.value = true;
      final result = await _apiService.fetchSubcategories();
      final filtered = result.where((s) => s.categoryId == categoryId).toList();
      subcategories.assignAll(filtered);
      filteredSubcategories.assignAll(filtered);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load subcategories');
    } finally {
      isLoading.value = false;
    }
  }

  /// Search subcategories
  void searchSubcategory(String query) {
    if (query.isEmpty) {
      filteredSubcategories.assignAll(subcategories);
    } else {
      filteredSubcategories.assignAll(
        subcategories.where(
          (s) => s.name.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }
}

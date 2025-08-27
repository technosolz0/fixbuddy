// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:fixbuddy/app/constants/api_constants.dart';

// import 'package:fixbuddy/app/modules/category/models/category_model.dart';
// import 'package:fixbuddy/app/modules/subCategory/models/subcategory_model.dart';
// import 'package:fixbuddy/app/modules/allservices/models/service_model.dart';

// import 'package:fixbuddy/app/data/models/user_cached_model.dart';
// import 'package:fixbuddy/app/modules/category/services/category_service.dart';
// import 'package:fixbuddy/app/modules/allservices/services/service_service.dart';
// import 'package:fixbuddy/app/modules/subCategory/services/subcategory_service.dart';
// import 'package:fixbuddy/app/utils/local_storage.dart';
// import 'package:path/path.dart';

// class HomeController extends GetxController {
//   var username = ''.obs;
//   var location = ''.obs;
//   final RxInt selectedIndex = 0.obs;

//   final RxList<CategoryModel> categories = <CategoryModel>[].obs;
//   final RxList<SubcategoryModel> subcategories = <SubcategoryModel>[].obs;
//   final RxList<ServiceModel> services = <ServiceModel>[].obs;

//   final CategoryApiService _categoryApiService = CategoryApiService();
//   final SubcategoryApiService _subcategoryApiService = SubcategoryApiService();
//   final ServiceApiService _serviceApiService = ServiceApiService();

//   final LocalStorage _localStorage = LocalStorage();

//   @override
//   void onInit() {
//     super.onInit();
//     loadUserFromCache();
//     fetchCategories();
//     fetchSubcategories();
//     fetchServices();
//   }

//   void changeTab(int index) {
//     selectedIndex.value = index;
//   }

//   void loadUserFromCache() async {
//     String? userJson = await _localStorage.pref.read(
//       key: _localStorage.userDetailsKey,
//     );
//     if (userJson != null) {
//       final user = UserCachedModel.fromJSON(jsonDecode(userJson));
//       username.value = user.fullName;
//     }
//   }

//   void fetchCategories() async {
//     try {
//       final List<CategoryModel> fetched = await _categoryApiService
//           .fetchCategories();

//       // ✅ Sort categories by ID descending (assuming higher ID = newer)
//       fetched.sort((a, b) => b.id.compareTo(a.id));

//       categories.value = fetched;
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load categories');
//     }
//   }

//   void fetchSubcategories() async {
//     try {
//       final data = await _subcategoryApiService.fetchSubcategories();
//       subcategories.assignAll(data);
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load subcategories');
//     }
//   }

//   void fetchServices() async {
//     try {
//       final data = await _serviceApiService.fetchServices();
//       services.assignAll(data);
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load services');
//     }
//   }

//   void openSubCategories(CategoryModel category) {
//     final selectedSubCategories = subcategories
//         .where((sub) => sub.categoryId == category.id)
//         .toList();

//     if (selectedSubCategories.isEmpty) {
//       Get.snackbar(
//         'Coming Soon',
//         'No sub-categories for ${category.name} added yet.',
//       );
//       return;
//     }
//     Get.bottomSheet(
//       Container(
//         padding: EdgeInsets.only(
//           left: 16,
//           right: 16,
//           top: 24,
//           bottom: MediaQuery.of(context ).viewInsets.bottom + 16,
//         ),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header row
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       category.name.capitalizeFirst ?? '',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () => Get.back(),
//                     icon: const Icon(Icons.close, color: Colors.black54),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Subcategory Grid
//               GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: selectedSubCategories.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 2.1,
//                   crossAxisSpacing: 12,
//                   mainAxisSpacing: 12,
//                 ),
//                 itemBuilder: (context, index) {
//                   final sub = selectedSubCategories[index];
//                   return Container(
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF7F8FA),
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 4,
//                           offset: Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     padding: const EdgeInsets.all(8),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         sub.image != null
//                             ? ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: Image.network(
//                                   '${ApiConstants.baseUrl}${sub.image}',
//                                   height: 40,
//                                   errorBuilder: (_, __, ___) => const Icon(
//                                     Icons.broken_image,
//                                     size: 36,
//                                     color: Colors.red,
//                                   ),
//                                 ),
//                               )
//                             : const Icon(
//                                 Icons.image,
//                                 size: 36,
//                                 color: Colors.grey,
//                               ),
//                         const SizedBox(height: 8),
//                         Text(
//                           sub.name.capitalizeFirst ?? '',
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       isScrollControlled: true,
//     );
//   }
// }

import 'dart:convert';

import 'package:fixbuddy/app/constants/app_color.dart'; // Assuming this exists for warningColor
import 'package:fixbuddy/app/modules/allservices/controllers/all_service_controller.dart';
import 'package:fixbuddy/app/utils/servex_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fixbuddy/app/constants/api_constants.dart';

import 'package:fixbuddy/app/modules/category/models/category_model.dart';
import 'package:fixbuddy/app/modules/subCategory/models/subcategory_model.dart';

import 'package:fixbuddy/app/data/models/user_cached_model.dart';
import 'package:fixbuddy/app/modules/category/services/category_service.dart';
import 'package:fixbuddy/app/modules/subCategory/services/subcategory_service.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
// No need for path/path.dart here as it's not used in the UI part

class HomeController extends GetxController {
  var username = ''.obs;
  var location = ''.obs;
  final RxInt selectedIndex = 0.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<SubcategoryModel> subcategories = <SubcategoryModel>[].obs;

  final CategoryApiService _categoryApiService = CategoryApiService();
  final SubcategoryApiService _subcategoryApiService = SubcategoryApiService();
  final AllServicesController servicesController = AllServicesController();

  final LocalStorage _localStorage = LocalStorage();

  @override
  void onInit() {
    super.onInit();
    loadUserFromCache();
    fetchCategories();
    fetchSubcategories();
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void loadUserFromCache() async {
    String? userJson = await _localStorage.pref.read(
      key: _localStorage.userDetailsKey,
    );
    if (userJson != null) {
      final user = UserCachedModel.fromJSON(jsonDecode(userJson));
      username.value = user.fullName!;
      final token = await _localStorage.getToken();
      ServexUtils.logPrint('Token: $token');
    }
  }

  Future<void> fetchCategories() async {
    try {
      final List<CategoryModel> fetched = await _categoryApiService
          .fetchCategories();

      // ✅ Sort categories by ID descending (assuming higher ID = newer)
      fetched.sort((a, b) => b.id.compareTo(a.id));

      categories.value = fetched;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load categories');
    }
  }

  void fetchSubcategories() async {
    try {
      final data = await _subcategoryApiService.fetchSubcategories();
      subcategories.assignAll(data);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load subcategories');
    }
  }

  // void fetchServices() async {
  //   try {
  //     final data = await _serviceApiService.fetchServices();
  //     services.assignAll(data);
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to load services');
  //   }
  // }

  // void navigateToServiceView(SubcategoryModel subcategory) {
  //   // Navigate to service view screen with subcategory data
  //   final filteredServices = services
  //       .where((service) => service.subCategoryId == subcategory.id)
  //       .toList();

  //   Get.toNamed(
  //     Routes.allServices,
  //     arguments: {'subcategory': subcategory, 'services': filteredServices},
  //   );
  // }

  void openSubCategories(CategoryModel category) {
    final selectedSubCategories = subcategories
        .where((sub) => sub.categoryId == category.id)
        .toList();

    if (selectedSubCategories.isEmpty) {
      Get.snackbar(
        'Coming Soon',
        'No sub-categories for ${category.name} added yet.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.shade100,
        colorText: AppColors.warningColor,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
      return;
    }

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 12,
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom + 20,
        ),
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 24,
              offset: Offset(0, -8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag Handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.grayColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.secondaryColor,
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    // ignore: unnecessary_null_comparison
                    child: category.image != null
                        ? Image.network(
                            '${ApiConstants.baseUrl}${category.image}',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.category,
                              size: 40,
                              color: Colors.grey,
                            ),
                          )
                        : const Icon(
                            Icons.category,
                            size: 40,
                            color: Colors.grey,
                          ),
                  ),
                ),
                const SizedBox(width: 16),

                // Title
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.name.capitalizeFirst ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Close button
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.close_rounded,
                    color: AppColors.grayColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Grid inside scroll
            // Flexible(
            //   child: SingleChildScrollView(
            //     child: GridView.builder(
            //       shrinkWrap: true,
            //       physics: const NeverScrollableScrollPhysics(),
            //       itemCount: selectedSubCategories.length,
            //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 2,
            //         childAspectRatio: 1.1,
            //         crossAxisSpacing: 16,
            //         mainAxisSpacing: 16,
            //       ),
            //       itemBuilder: (context, index) {
            //         final sub = selectedSubCategories[index];
            //         return _buildSubcategoryCard(sub);
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
    );
  }

  /// Pull-to-refresh
  Future<void> refreshhome() async {
    await fetchCategories();
  }

  /// Retry on error
  Future<void> retry() async {
    await fetchCategories();
  }
}

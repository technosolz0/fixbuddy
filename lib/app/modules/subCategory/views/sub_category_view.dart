import 'package:fixbuddy/app/constants/api_constants.dart';
import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/modules/subCategory/controllers/sub_category_controller.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/utils/extensions.dart';
import 'package:fixbuddy/app/utils/shimmerLoader.dart';
import 'package:fixbuddy/app/widgets/customListTile.dart';
import 'package:fixbuddy/app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoryView extends StatefulWidget {
  const SubCategoryView({super.key});

  @override
  State<SubCategoryView> createState() => _SubCategoryViewState();
}

class _SubCategoryViewState extends State<SubCategoryView> {
  final SubcategoryController controller = Get.put(SubcategoryController());

  @override
  @override
  void initState() {
    super.initState();

    final args = Get.arguments as Map<String, dynamic>?; // safely cast
    final categoryId = args?['categoryId'] as int?;

    if (categoryId != null) {
      controller.fetchByCategory(categoryId);
    } else {
      controller.fetchSubcategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(title: 'Sub Categories', centerTitle: true),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            height: size.height * 0.25,
            decoration: BoxDecoration(
              gradient: context.isLightTheme
                  ? AppColors.lightThemeGradient
                  : AppColors.darkThemeGradient,
            ),
          ),

          // Foreground content
          Obx(() {
            if (controller.isLoading.value) {
              return buildShimmerLoader();
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Category',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: AppColors.whiteColor,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: controller.searchSubcategory,
                  ),
                ),
                // 📋 Subcategory List
                Expanded(
                  child: Obx(() {
                    final filtered = controller.filteredSubcategories;

                    if (filtered.isEmpty) {
                      return const Center(
                        child: Text("No Sub Categories found."),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final sub = filtered[index];
                        final status = sub.status.toLowerCase();

                        Color statusColor;
                        switch (status) {
                          case 'active':
                            statusColor = AppColors.successColor;
                            break;
                          case 'inactive':
                            statusColor = AppColors.errorColor;
                            break;
                          default:
                            statusColor = Colors.grey;
                        }

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CustomListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(26),
                              child: sub.image != null
                                  ? Image.network(
                                      '${ApiConstants.baseUrl}/${sub.image}',
                                      width: 52,
                                      height: 52,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          const Icon(Icons.broken_image),
                                    )
                                  : const Icon(Icons.image, size: 48),
                            ),
                            title: Text(
                              sub.name.toCapitalized(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                              ),
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                sub.status.toCapitalized(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: statusColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            onTap: () {
                              Get.toNamed(
                                Routes.allServices,
                                arguments: {
                                  'categoryId': sub.categoryId,
                                  'subCategoryId': sub.id,
                                },
                              );
                            },
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

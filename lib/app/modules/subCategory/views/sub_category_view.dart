import 'package:fixbuddy/app/constants/api_constants.dart';
import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/modules/subCategory/controllers/sub_category_controller.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/utils/extensions.dart';
import 'package:fixbuddy/app/utils/shimmerLoader.dart';
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
  void initState() {
    super.initState();
    final args = Get.arguments as List?;
    if (args != null && args.isNotEmpty) {
      final categoryId = args[0] as int;
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
            height: size.height * 0.2,
            decoration: BoxDecoration(
              gradient: context.isLightTheme
                  ? AppColors.lightThemeGradient
                  : AppColors.darkThemeGradient,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Sub-Category',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: context.isLightTheme
                            ? AppColors.whiteColor.withOpacity(0.9)
                            : AppColors.blackColor.withOpacity(0.9),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: controller.searchSubcategory,
                    ),
                  ),

                  // Subcategory Grid
                  Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return buildShimmerLoader();
                      }

                      final filtered = controller.filteredSubcategories;
                      if (filtered.isEmpty) {
                        return const Center(
                          child: Text("No Sub Categories found."),
                        );
                      }

                      return GridView.builder(
                        itemCount: filtered.length,
                        padding: const EdgeInsets.only(top: 8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.85,
                            ),
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

                          return InkWell(
                            onTap: () {
                              Get.toNamed(
                                Routes.allServices,
                                arguments: {
                                  'categoryId': sub.categoryId,
                                  'subCategoryId': sub.id,
                                },
                              );
                            },
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: sub.image != null
                                            ? Image.network(
                                                '${ApiConstants.baseUrl}${sub.image}',
                                                fit: BoxFit.cover,
                                                errorBuilder: (_, _, _) =>
                                                    const Icon(
                                                      Icons.broken_image,
                                                      size: 60,
                                                    ),
                                              )
                                            : const Icon(Icons.image, size: 60),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      sub.name.toCapitalized(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.blackColor,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: statusColor.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        sub.status.toCapitalized(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: statusColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

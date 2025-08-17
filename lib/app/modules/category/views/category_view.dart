import 'package:fixbuddy/app/constants/api_constants.dart';
import 'package:fixbuddy/app/modules/category/controllers/category_controller.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/utils/extensions.dart';
import 'package:fixbuddy/app/utils/shimmerLoader.dart';
import 'package:flutter/material.dart';
import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/widgets/customListTile.dart';
import 'package:fixbuddy/app/widgets/custom_app_bar.dart';
import 'package:get/get.dart';

class CategoryView extends StatelessWidget {
  CategoryView({super.key});

  final CategoryController controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Categories', centerTitle: true),
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
                    onChanged: controller.searchCategory,
                  ),
                ),

                Expanded(
                  child: controller.filteredCategories.isEmpty
                      ? const Center(child: Text("No categories found."))
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          itemCount: controller.filteredCategories.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final category =
                                controller.filteredCategories[index];
                            final status = category.status.toLowerCase();

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
                                leading: CircleAvatar(
                                  radius: 26,
                                  backgroundImage: NetworkImage(
                                    '${ApiConstants.baseUrl}${category.image}',
                                  ),
                                ),
                                title: Text(
                                  category.name.toCapitalized(),
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
                                    category.status.toCapitalized(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: statusColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),

                                onTap: () {
                                  Get.toNamed(
                                    Routes.subcategory,
                                    arguments: [category.id],
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

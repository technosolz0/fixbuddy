import 'package:fixbuddy/app/constants/api_constants.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:get/get.dart';
import 'package:fixbuddy/app/modules/home/controllers/home_controller.dart';
import 'package:fixbuddy/app/modules/category/models/category_model.dart';

class CategoryGridWidget extends StatelessWidget {
  final Function(CategoryModel) onCategoryTap;

  CategoryGridWidget({super.key, required this.onCategoryTap});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.categories.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      // ✅ Copy, sort by ID descending, and take the latest 5
      final sortedCategories = controller.categories.toList()
        ..sort((a, b) => b.id.compareTo(a.id));
      final latestCategories = sortedCategories.take(5).toList();

      return GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: latestCategories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final category = latestCategories[index];
          return GestureDetector(
            // onTap: () => onCategoryTap(category),
            onTap: () {
              Get.toNamed(
                Routes.subcategory,
                arguments: {
                  'categoryId': category.id,
                  'categoryName': category.name,
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Image.network(
                    '${ApiConstants.baseUrl}${category.image}',
                    height: 80,
                    width: 250,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.error,
                        size: 50,
                        color: AppColors.secondaryColor,
                      );
                    },
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      category.name.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

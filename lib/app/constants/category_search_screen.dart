import 'package:fixbuddy/app/constants/api_constants.dart';
import 'package:fixbuddy/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/modules/category/models/category_model.dart';

class CategorySearchScreen extends StatelessWidget {
  final RxList<CategoryModel> filtered = <CategoryModel>[].obs;
  final List<CategoryModel> allCategories = Get.arguments;
  final RxString query = ''.obs;

  CategorySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Categories"),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                query.value = value;
                _filterCategories(value);
              },
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (query.value.trim().isEmpty) {
                return const Center(child: Text("Type to search categories"));
              }
              if (filtered.isEmpty) {
                return const Center(child: Text("No categories found"));
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, index) {
                  final cat = filtered[index];
                  return ListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        '${ApiConstants.baseUrl}${cat.image}',
                      ),
                      backgroundColor: AppColors.lightGrayColor,
                    ),
                    title: Text(
                      cat.name.toCapitalized(),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      Get.back(result: cat); // Return the selected category
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void _filterCategories(String query) {
    final results = allCategories
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    filtered.assignAll(results);
  }
}

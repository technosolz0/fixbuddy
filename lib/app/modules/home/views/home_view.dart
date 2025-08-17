import 'package:fixbuddy/app/modules/category/models/category_model.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/utils/extensions.dart';
import 'package:fixbuddy/app/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fixbuddy/app/modules/home/views/widgets/category_grid_widget.dart';
import 'package:fixbuddy/app/constants/app_color.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  @override
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: AppColors.grayColor,
      body: Stack(
        children: [
          // _buildHeaderBackground(size),
          Container(
            height: size.height * 0.45,
            decoration: BoxDecoration(
              gradient: context.isLightTheme
                  ? AppColors.lightThemeGradient
                  : AppColors.darkThemeGradient,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderRow(),
                  const SizedBox(height: 4),
                  Obx(
                    () => Text(
                      controller.location.value,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSearchBar(),
                  const SizedBox(height: 16),
                  _buildOfferBanner(size),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Category",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: context.isLightTheme
                              ? AppColors.blackColor
                              : AppColors.whiteColor,
                        ),
                      ),
                      CustomTextButton(
                        textColor: context.isLightTheme
                            ? AppColors.blackColor
                            : AppColors.whiteColor,
                        label: context.l10n.view_all,
                        onPressed: () {
                          Get.toNamed(Routes.category);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: CategoryGridWidget(
                      onCategoryTap: (CategoryModel category) {
                        controller.openSubCategories(category);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => Text(
            'Hello ${controller.username.value.split(' ').first.capitalizeFirst}!',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.notifications_none,
                size: 28,
                color: AppColors.blackColor,
              ),
              onPressed: () => Get.toNamed('/notification'),
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                size: 28,
                color: AppColors.blackColor,
              ),
              onPressed: () => Get.toNamed('/setting'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.categorySearch, arguments: controller.categories);
      },
      child: AbsorbPointer(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search Categories',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOfferBanner(Size size) {
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Up to 50% Offer",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Book now to avail the offer",
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    backgroundColor: AppColors.secondaryColor,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text("Explore Now"),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Image.asset(
            'assets/images/cleaning.png',
            height: 80,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error, size: 50, color: Colors.red);
            },
          ),
        ],
      ),
    );
  }
}

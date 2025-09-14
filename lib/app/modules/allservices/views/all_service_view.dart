import 'package:fixbuddy/app/modules/allservices/controllers/all_service_controller.dart';
import 'package:fixbuddy/app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/utils/shimmerLoader.dart';

class AllServicesView extends StatelessWidget {
  const AllServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    final AllServicesController controller = Get.put(AllServicesController());

    return Scaffold(
      appBar: const CustomAppBar(title: 'All Services', centerTitle: true),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(gradient: AppColors.lightThemeGradient),
          ),

          SafeArea(
            child: Obx(() {
              if (controller.isLoading.value) {
                return buildShimmerLoader();
              }

              if (controller.errorMessage.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "⚠️ ${controller.errorMessage.value}",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.blackColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => controller.retry(),
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                );
              }

              if (controller.vendorResponse.value == null ||
                  controller.vendorResponse.value!.vendors.isEmpty) {
                return const Center(child: Text("No services available."));
              }

              final vendors = controller.vendorResponse.value!.vendors;

              return RefreshIndicator(
                onRefresh: () => controller.refreshVendors(),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  itemCount: vendors.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final vendor = vendors[index];

                    final vendorName = vendor.vendorDetails?.name ?? "No Name";
                    final vendorId = vendor.vendorDetails?.id ?? 0;
                    // ignore: unnecessary_null_comparison
                    final vendorPrice = vendor.serviceCharge != null
                        ? "₹${vendor.serviceCharge}"
                        : "0";
                    final vendorRating = vendor.rating;

                    return _buildAllServicesCard(
                      vendorId: vendorId,
                      title: vendorName,
                      price: vendorPrice,
                      rating: vendorRating,
                      controller: controller,
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildAllServicesCard({
    required int vendorId,
    required String title,
    required String price,
    required double rating,
    required AllServicesController controller,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Service Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Action Button
          ElevatedButton(
            onPressed: () {
              controller.startPayment(
                vendorId: vendorId,
                categoryId: controller.categoryId!,
                subCategoryId: controller.subCategoryId!,
                amount: double.tryParse(price.replaceAll('₹', '')) ?? 0.0,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text(
              "Book Now",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

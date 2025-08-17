import 'package:fixbuddy/app/modules/allservices/controllers/all_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/widgets/customListTile.dart';
import 'package:fixbuddy/app/widgets/custom_app_bar.dart';

class AllServicesView extends StatelessWidget {
  const AllServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final AllServicesController controller = Get.put(AllServicesController());

    return Scaffold(
      appBar: const CustomAppBar(title: 'All Services', centerTitle: true),
      body: Stack(
        children: [
          // Background gradient
          Container(
            height: size.height * 0.25,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.secondaryColor,
                  AppColors.tritoryColor,
                  AppColors.whiteColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Services list
          Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("⚠️ ${controller.errorMessage.value}"),
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
                  controller.vendorResponse.value!.vendors == null ||
                  controller.vendorResponse.value!.vendors!.isEmpty) {
                return const Center(child: Text("No services available"));
              }

              final vendors = controller.vendorResponse.value!.vendors!;

              return RefreshIndicator(
                onRefresh: () => controller.refreshVendors(),
                child: ListView.builder(
                  itemCount: vendors.length,
                  itemBuilder: (context, index) {
                    final vendor = vendors[index];

                    final vendorName = vendor.vendorDetails?.name ?? "No Name";
                    final vendorPrice = vendor.serviceCharge != null
                        ? "₹${vendor.serviceCharge}"
                        : "Price N/A";

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildAllServicesCard(
                        title: vendorName,
                        status: "Available",
                        date: "—", // TODO: replace with API date if available
                        price: vendorPrice,
                      ),
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
    required String title,
    required String status,
    required String date,
    required String price,
  }) {
    Color statusColor;

    switch (status) {
      case 'Completed':
        statusColor = Colors.green;
        break;
      case 'Scheduled':
        statusColor = Colors.orange;
        break;
      case 'Cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: CustomListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '$date  •  $price',
          style: const TextStyle(color: Colors.black54),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: TextStyle(color: statusColor, fontWeight: FontWeight.w500),
          ),
        ),
        onTap: () {
          // TODO: Navigate to vendor details page
        },
      ),
    );
  }
}

import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/modules/address/controllers/address_controller.dart';
import 'package:fixbuddy/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_address_view.dart';
import 'edit_address_view.dart';

class AddressView extends StatelessWidget {
  final AddressController controller = Get.put(AddressController());
  final ProfileController profileController = Get.put(ProfileController());

  AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrayColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "My Addresses",
          style: TextStyle(
            color: AppColors.blackColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.blackColor),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.blackColor),
            onPressed: () async {
              // trigger re-fetch
              await profileController.fetchAddresses();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(color: AppColors.errorColor),
            ),
          );
        }

        if (profileController.alladdresses.isEmpty) {
          return const Center(
            child: Text(
              "No addresses found",
              style: TextStyle(color: AppColors.errorColor, fontSize: 16),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await profileController.fetchAddresses();
          },
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            itemCount: profileController.alladdresses.length,
            separatorBuilder: (_, _) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final address = profileController.alladdresses[index];
              final isDefault = address.isDefault;

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: isDefault
                      ? const BorderSide(
                          color: Colors.green,
                          width: 2,
                        ) // green border
                      : BorderSide.none,
                ),
                elevation: 2,
                color:
                    //  isDefault
                    // ? Colors.green.withOpacity(0.9) // light green background
                    // :
                    AppColors.whiteColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: ListTile(
                    minVerticalPadding: 0,
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primaryColor.withOpacity(0.20),
                      child: Icon(
                        address.addressType.toLowerCase() == "work"
                            ? Icons.work
                            : Icons.home,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            address.name,
                            style: const TextStyle(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (isDefault)
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 18,
                          ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        "${address.address}, ${address.city}, ${address.state} - ${address.pinCode}",
                        style: const TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () =>
                              Get.to(() => EditAddressView(address: address)),
                          tooltip: "Edit",
                          splashRadius: 22,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: AppColors.errorColor,
                          ),
                          onPressed: () => controller.deleteAddress(address.id),
                          tooltip: "Delete",
                          splashRadius: 22,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryColor,
        label: const Text(
          "Add Address",
          style: TextStyle(
            color: AppColors.blackColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        icon: const Icon(Icons.add, color: AppColors.blackColor),
        onPressed: () => Get.to(() => AddAddressView()),
        elevation: 4,
      ),
    );
  }
}

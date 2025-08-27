import 'package:fixbuddy/app/modules/address/models/address_model.dart';
import 'package:fixbuddy/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/modules/address/services/address_service.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';

class AddressController extends GetxController {
  final AddressApiService apiService = AddressApiService();

  final ProfileController profileController = Get.put(ProfileController());

  var addresses = <AddressModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = "".obs;

  final formKey = GlobalKey<FormState>();

  // Controllers
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final landmarkCtrl = TextEditingController();
  final stateCtrl = TextEditingController();
  final pincodeCtrl = TextEditingController();
  final countryCtrl = TextEditingController();
  final addressTypeCtrl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> addAddress(AddressModel address) async {
    try {
      isLoading.value = true;
      final result = await apiService.addAddress(address);
      if (result.statusCode == 200 || result.statusCode == 201) {
        addresses.add(result.data);
        profileController.fetchAddresses();
        Get.toNamed(Routes.address);

        Get.snackbar(
          "Success",
          "Address added successfully",
          backgroundColor: AppColors.successColor,
          colorText: AppColors.whiteColor,
        );
      } else {
        Get.snackbar("Error", "Failed to add address: ${result.statusCode}");
      }
    } catch (e, stackTrace) {
      Get.snackbar("Error", "Failed to add address: $e");
      print('addAddress error: $e\n$stackTrace');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateAddress(AddressModel address) async {
    try {
      isLoading.value = true;
      final result = await apiService.updateAddress(address);
      if (result.statusCode == 200) {
        int index = addresses.indexWhere((a) => a.id == address.id);
        if (index != -1) addresses[index] = result.data;

        profileController.fetchAddresses();
        Get.toNamed(Routes.address);
        Get.snackbar("Success", "Address updated successfully");
      } else {
        Get.snackbar("Error", "Failed to update address: ${result.statusCode}");
      }
    } catch (e, stackTrace) {
      Get.snackbar("Error", "Failed to update address: $e");
      print('updateAddress error: $e\n$stackTrace');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteAddress(int id) async {
    try {
      isLoading.value = true;
      final result = await apiService.deleteAddress(id);
      if (result.statusCode == 200) {
        addresses.removeWhere((a) => a.id == id);

        profileController.fetchAddresses();
        Get.toNamed(Routes.address);
        Get.snackbar("Success", "Address deleted successfully");
      } else {
        Get.snackbar("Error", "Failed to delete address: ${result.statusCode}");
      }
    } catch (e, stackTrace) {
      Get.snackbar("Error", "Failed to delete address: $e");
      print('deleteAddress error: $e\n$stackTrace');
    } finally {
      isLoading.value = false;
    }
  }
}

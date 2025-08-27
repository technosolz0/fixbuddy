import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/constants/address_constants.dart';
import 'package:fixbuddy/app/modules/address/controllers/address_controller.dart';
import 'package:fixbuddy/app/modules/address/models/address_model.dart';
import 'package:fixbuddy/app/modules/address/views/widgets/custom_widgets.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:fixbuddy/app/widgets/custom_button.dart';
import 'package:fixbuddy/app/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressView extends StatelessWidget {
  final AddressController controller = Get.find();
  final LocalStorage localStorage = LocalStorage();

  AddAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.lightThemeGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Custom AppBar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.blackColor,
                      ),
                      onPressed: () => Get.back(),
                    ),
                    const Expanded(
                      child: Text(
                        "Add New Address",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              // Form
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: controller.nameCtrl,
                          label: "Full Name",
                          validator: (value) =>
                              (value == null || value.trim().isEmpty)
                              ? 'Please enter name'
                              : null,
                        ),
                        const SizedBox(height: 15),

                        CustomTextField(
                          controller: controller.phoneCtrl,
                          label: "Phone Number",
                          inputType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter phone number';
                            }
                            if (!RegExp(
                              r'^[0-9]{10,15}$',
                            ).hasMatch(value.trim())) {
                              return 'Enter valid phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),

                        CustomTextField(
                          controller: controller.addressCtrl,
                          label: "Address Line",
                          validator: (value) =>
                              (value == null || value.trim().isEmpty)
                              ? 'Please enter address'
                              : null,
                        ),
                        const SizedBox(height: 15),

                        CustomDropdown(
                          label: "Select City",
                          value: controller.cityCtrl.text,
                          items: AddressConstants.cities,
                          onChanged: (val) {
                            controller.cityCtrl.text = val!;
                          },
                        ),
                        const SizedBox(height: 15),

                        CustomTextField(
                          controller: controller.landmarkCtrl,
                          label: "Landmark (Optional)",
                        ),
                        const SizedBox(height: 15),

                        CustomDropdown(
                          label: "Select State",
                          value: controller.stateCtrl.text,
                          items: AddressConstants.states,
                          onChanged: (val) {
                            controller.stateCtrl.text = val ?? '';
                          },
                        ),
                        const SizedBox(height: 15),

                        CustomTextField(
                          controller: controller.pincodeCtrl,
                          label: "Pincode",
                          inputType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter pincode';
                            }
                            if (!RegExp(
                              r'^[0-9]{4,10}$',
                            ).hasMatch(value.trim())) {
                              return 'Enter valid pincode';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),

                        CustomDropdown(
                          label: "Select Country",
                          value: controller.countryCtrl.text.isEmpty
                              ? "India"
                              : controller.countryCtrl.text,
                          items: AddressConstants.countries,
                          onChanged: (val) {
                            controller.countryCtrl.text = val ?? 'India';
                          },
                        ),
                        const SizedBox(height: 15),

                        CustomDropdown(
                          label: "Select Address Type",

                          value: controller.addressTypeCtrl.text.isEmpty
                              ? "Home"
                              : controller.addressTypeCtrl.text,
                          items: AddressConstants.addressTypes,
                          onChanged: (val) {
                            controller.addressTypeCtrl.text = val ?? 'Home';
                          },
                        ),
                        const SizedBox(height: 30),

                        CustomButton(
                          text: "Save Address",
                          onPressed: () async {
                            final int? currentUserId = await localStorage
                                .getUserID();
                            if (currentUserId == null) {
                              Get.snackbar("Error", "User not logged in");
                              return;
                            }
                            if (controller.formKey.currentState!.validate()) {
                              final address = AddressModel(
                                id: 0,
                                userId: currentUserId,
                                name: controller.nameCtrl.text.trim(),
                                phone: controller.phoneCtrl.text.trim(),
                                address: controller.addressCtrl.text.trim(),
                                landmark: controller.landmarkCtrl.text.trim(),
                                city: controller.cityCtrl.text.trim(),
                                state: controller.stateCtrl.text.trim(),
                                pinCode: controller.pincodeCtrl.text.trim(),
                                country: controller.countryCtrl.text.isEmpty
                                    ? "India"
                                    : controller.countryCtrl.text.trim(),
                                addressType:
                                    controller.addressTypeCtrl.text.isEmpty
                                    ? "Home"
                                    : controller.addressTypeCtrl.text.trim(),
                                isDefault: false,
                              );
                              await controller.addAddress(address);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/constants/address_constants.dart';
import 'package:fixbuddy/app/modules/address/controllers/address_controller.dart';
import 'package:fixbuddy/app/modules/address/models/address_model.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:fixbuddy/app/widgets/custom_button.dart';
import 'package:fixbuddy/app/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAddressView extends StatefulWidget {
  final AddressModel address;
  const EditAddressView({super.key, required this.address});

  @override
  State<EditAddressView> createState() => _EditAddressViewState();
}

class _EditAddressViewState extends State<EditAddressView> {
  final AddressController controller = Get.find();
  final LocalStorage localStorage = LocalStorage();

  // Extra controllers
  final countryCtrl = TextEditingController();
  final addressTypeCtrl = TextEditingController();
  bool isDefault = false;

  @override
  void initState() {
    super.initState();

    // Pre-fill controllers
    controller.nameCtrl.text = widget.address.name;
    controller.phoneCtrl.text = widget.address.phone;
    controller.addressCtrl.text = widget.address.address;
    controller.landmarkCtrl.text = widget.address.landmark ?? '';
    controller.cityCtrl.text = widget.address.city;
    controller.stateCtrl.text = widget.address.state;
    controller.pincodeCtrl.text = widget.address.pinCode;
    countryCtrl.text = widget.address.country;
    addressTypeCtrl.text = widget.address.addressType;
    isDefault = widget.address.isDefault;
  }

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
                        "Edit Address",
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
                        buildLabel("Full Name"),
                        buildField(
                          controller.nameCtrl,
                          "Enter full name",
                          validator: (v) => v!.isEmpty ? "Required" : null,
                        ),

                        buildLabel("Phone Number"),
                        buildField(
                          controller.phoneCtrl,
                          "Enter phone number",
                          inputType: TextInputType.phone,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return "Required";
                            }
                            if (!RegExp(r'^[0-9]{10,15}$').hasMatch(v)) {
                              return "Invalid phone number";
                            }
                            return null;
                          },
                        ),

                        buildLabel("Address"),
                        buildField(
                          controller.addressCtrl,
                          "Enter address",
                          validator: (v) => v!.isEmpty ? "Required" : null,
                        ),

                        buildLabel("Landmark"),
                        buildField(controller.landmarkCtrl, "Enter landmark"),

                        buildLabel("City"),
                        CustomDropdown(
                          label: "Select City",
                          value: controller.cityCtrl.text,
                          items: AddressConstants.cities,
                          onChanged: (val) {
                            setState(() {
                              controller.cityCtrl.text = val ?? '';
                            });
                          },
                        ),

                        buildLabel("State"),
                        CustomDropdown(
                          label: "Select State",
                          value: controller.stateCtrl.text,
                          items: AddressConstants.states,
                          onChanged: (val) {
                            setState(() {
                              controller.stateCtrl.text = val ?? '';
                            });
                          },
                        ),

                        buildLabel("Pincode"),
                        buildField(
                          controller.pincodeCtrl,
                          "Enter pincode",
                          inputType: TextInputType.number,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return "Required";
                            }
                            if (!RegExp(r'^[0-9]{4,10}$').hasMatch(v)) {
                              return "Invalid pincode";
                            }
                            return null;
                          },
                        ),

                        buildLabel("Country"),
                        CustomDropdown(
                          label: "Select Country",
                          value: countryCtrl.text,
                          items: AddressConstants.countries,
                          onChanged: (val) {
                            setState(() {
                              countryCtrl.text = val ?? '';
                            });
                          },
                        ),

                        buildLabel("Address Type"),
                        CustomDropdown(
                          label: "Select Address Type",
                          value: addressTypeCtrl.text,
                          items: AddressConstants.addressTypes,
                          onChanged: (val) {
                            setState(() {
                              addressTypeCtrl.text = val ?? '';
                            });
                          },
                        ),

                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Set as Default",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackColor,
                              ),
                            ),
                            Switch(
                              value: isDefault,
                              activeColor: AppColors.primaryColor,
                              onChanged: (val) {
                                setState(() => isDefault = val);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        CustomButton(
                          text: "Update Address",
                          onPressed: () async {
                            final int? currentUserId = await localStorage
                                .getUserID();

                            if (currentUserId == null) {
                              Get.snackbar("Error", "User not logged in");
                              return;
                            }
                            if (controller.formKey.currentState!.validate()) {
                              final updated = AddressModel(
                                id: widget.address.id,
                                userId: currentUserId,
                                name: controller.nameCtrl.text.trim(),
                                phone: controller.phoneCtrl.text.trim(),
                                address: controller.addressCtrl.text.trim(),
                                landmark: controller.landmarkCtrl.text.trim(),
                                city: controller.cityCtrl.text.trim(),
                                state: controller.stateCtrl.text.trim(),
                                pinCode: controller.pincodeCtrl.text.trim(),
                                country: countryCtrl.text.trim(),
                                addressType: addressTypeCtrl.text.trim(),
                                isDefault: isDefault,
                              );
                              await controller.updateAddress(updated);
                              Get.back();
                              Get.snackbar(
                                "Success",
                                "Address Updated",
                                backgroundColor: AppColors.successColor,
                                colorText: AppColors.whiteColor,
                              );
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

  // helper widgets
  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.blackColor,
        ),
      ),
    );
  }

  Widget buildField(
    TextEditingController ctrl,
    String hint, {
    TextInputType inputType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: inputType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.grayColor),
        filled: true,
        fillColor: AppColors.lightGrayColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

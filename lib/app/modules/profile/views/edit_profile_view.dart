// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fixbuddy/app/constants/address_constants.dart';
import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/constants/app_constants.dart';
import 'package:fixbuddy/app/modules/profile/controllers/edit_profile_controller.dart';
import 'package:fixbuddy/app/widgets/custom_button.dart';
import 'package:fixbuddy/app/widgets/custom_dropdown.dart';
import 'package:fixbuddy/app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/validations.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  void initState() {
    super.initState();
    // FAnalytics.logScreen(screenName: 'Edit Profile');
  }

  @override
  void dispose() {
    Get.delete<EditProfileController>();
    super.dispose();
  }

  EditProfileController controller = Get.put<EditProfileController>(
    EditProfileController(),
  );
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.isProfileChanged) {
          // showUnsavedEditDialog();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Profile",
            style: TextStyle(
              fontSize: 22.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Expanded(
                child: Form(
                  key: controller.key,
                  child: ListView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    children: [
                      GestureDetector(
                        onTap: () => showImagePickerBottomSheet(context),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Stack(
                            children: [
                              Obx(() {
                                if (controller.imageStatus.value == 0) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      color: AppColors.whiteColor,
                                      shape: BoxShape.circle,
                                    ),
                                    height: 100.w,
                                    width: 100.w,
                                    alignment: Alignment.center,
                                    child: Text(
                                      controller.firstNameController.text
                                              .trim()[0]
                                              .toUpperCase() +
                                          controller.lastNameController.text
                                              .trim()[0]
                                              .toUpperCase(),
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 50.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                } else if (controller.imageStatus.value == 1) {
                                  return CachedNetworkImage(
                                    imageUrl: controller.image.value,
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        width: 100.w,
                                        height: 100.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return CircleAvatar(
                                    radius: 50.r,
                                    backgroundImage: FileImage(
                                      controller.galleryImage,
                                    ),
                                  );
                                }
                              }),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  height: 24.w,
                                  width: 24.w,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 16.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 26.h),
                      Obx(
                        () => Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: AppColors.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: DropdownButton(
                            items: List<DropdownMenuItem<String>>.from(
                              controller.prefixDropdownItems
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                            ),
                            value: controller.selectedPrefixTitle.value,
                            onChanged: (val) {
                              controller.isProfileChanged = true;
                              controller.selectedPrefixTitle.value = val!;
                            },
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            padding: EdgeInsets.symmetric(
                              horizontal: 18.w,
                              vertical: 5.h,
                            ),
                            underline: const SizedBox(),
                          ),
                        ),
                      ),
                      SizedBox(height: 31.h),
                      CustomTextFormField(
                        textInputAction: TextInputAction.next,
                        controller: controller.firstNameController,
                        name: 'First Name',
                        onChanged: (p0) {
                          controller.isProfileChanged = true;
                        },
                        validator: (val) {
                          return Validator.emptyValidation('First Name', val);
                        },
                        hintText: 'Enter your first name',
                      ),
                      SizedBox(height: 24.h),
                      CustomTextFormField(
                        textInputAction: TextInputAction.next,
                        controller: controller.middleNameController,
                        name: 'Middle Name',
                        onChanged: (p0) {
                          controller.isProfileChanged = true;
                        },
                        hintText: 'Enter your middle name',
                      ),
                      SizedBox(height: 24.h),
                      CustomTextFormField(
                        textInputAction: TextInputAction.next,
                        controller: controller.lastNameController,
                        name: 'Last Name',
                        onChanged: (p0) {
                          controller.isProfileChanged = true;
                        },
                        validator: (val) {
                          return Validator.emptyValidation('Last Name', val);
                        },
                        hintText: '',
                      ),
                      SizedBox(height: 42.h),
                      const TitleText(text: "Personal Detail"),
                      SizedBox(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Gender",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            height: 30.h,
                            width: 125.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Obx(
                              () => PrivacyDropDown(
                                controller: controller,
                                text: controller.genderPrivacy.value,
                                onChanged: (val) {
                                  controller.isProfileChanged = true;
                                  controller.genderPrivacy.value = val!;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h),
                      Obx(
                        () => Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: AppColors.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: DropdownButton(
                            items: List<DropdownMenuItem<String>>.from(
                              controller.genderDropdownItems
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                            ),
                            value: controller.selectedGender.value,
                            onChanged: (val) {
                              controller.isProfileChanged = true;
                              controller.selectedGender.value = val!;
                            },
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            padding: EdgeInsets.symmetric(
                              horizontal: 18.w,
                              vertical: 5.h,
                            ),
                            underline: const SizedBox(),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Date Of Birth",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            height: 30.h,
                            width: 125.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Obx(
                              () => PrivacyDropDown(
                                controller: controller,
                                text: controller.dobPrivacy.value,
                                onChanged: (val) {
                                  controller.isProfileChanged = true;
                                  controller.dobPrivacy.value = val!;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      
                      SizedBox(height: 42.h),
                      const TitleText(text: "Location"),
                      SizedBox(height: 24.h),
                      CustomTextFormField(
                        textInputAction: TextInputAction.next,
                        controller: controller.cityController,
                        name: 'City',
                        onChanged: (p0) {
                          controller.isProfileChanged = true;
                        },
                        validator: (val) {
                          return Validator.emptyValidation('City', val);
                        },
                        hintText: 'City',
                      ),
                      SizedBox(height: 24.h),
                      Obx(
                        () => Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: AppColors.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child:
                              // DropdownButton(
                              //   items: List<DropdownMenuItem<String>>.from(
                              //     AddressConstants.countries
                              //         .map(
                              //           (e) => DropdownMenuItem(
                              //             value: e['name'].toString(),
                              //             child: Text(e['name']),
                              //           ),
                              //         )
                              //         .toList(),
                              //   ),
                              //   value: controller.selectedCountry.value,
                              //   onChanged: (val) {
                              //     controller.isProfileChanged = true;
                              //     controller.selectedCountry.value = val!;
                              //   },
                              //   isExpanded: true,
                              //   icon: const Icon(Icons.keyboard_arrow_down_rounded),
                              //   padding: EdgeInsets.symmetric(
                              //     horizontal: 18.w,
                              //     vertical: 5.h,
                              //   ),
                              //   underline: const SizedBox(),
                              // ),
                              CustomDropdown(
                                label: "Select Country",
                                value: controller.selectedCountry.value == ""
                                    ? "India"
                                    : controller.selectedCountry.value,
                                items: AddressConstants.countries,
                                onChanged: (val) {
                                  controller.isProfileChanged = true;
                                  controller.selectedCountry.value = val!;
                                },
                              ),
                        ),
                      ),
                      SizedBox(height: 42.h),
                      const TitleText(text: "contact Details"),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Contact Number",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            height: 30.h,
                            width: 125.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Obx(
                              () => PrivacyDropDown(
                                controller: controller,
                                text: controller.contactPrivacy.value,
                                onChanged: (val) {
                                  controller.isProfileChanged = true;
                                  controller.contactPrivacy.value = val!;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h),
                      CustomTextFormField(
                        textInputAction: TextInputAction.next,
                        controller: controller.phoneController,
                        name: '',
                        // prefixIcon: CountryCodePicker(
                        //   onChanged: (val) {
                        //     controller.selectedPhoneCode.value =
                        //         val.dialCode ?? '';

                        //     controller.isProfileChanged = true;
                        //   },
                        //   showFlag: false,
                        //   showFlagDialog: true,
                        //   padding: EdgeInsets.zero,
                        //   initialSelection: controller.selectedPhoneCode.value,
                        //   textStyle: TextStyle(
                        //     fontSize: 18.sp,
                        //     color: AppColors.blackColor,
                        //   ),
                        // ),
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          return Validator.phoneValidation('', val);
                        },
                        hintText: 'Contact Number',
                      ),
                      SizedBox(height: 29.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            height: 30.h,
                            width: 125.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Obx(
                              () => PrivacyDropDown(
                                controller: controller,
                                text: controller.emailPrivacy.value,
                                onChanged: (val) {
                                  controller.isProfileChanged = true;
                                  controller.emailPrivacy.value = val!;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h),
                      CustomTextFormField(
                        textInputAction: TextInputAction.next,
                        controller: controller.emailController,
                        name: '',
                        onChanged: (p0) {
                          controller.isProfileChanged = true;
                        },
                        validator: (val) {
                          return Validator.emptyValidation('City', val);
                        },
                      ),
                      SizedBox(height: 50.h),
                      const TitleText(text: "Current Status"),
                      SizedBox(height: 14.h),
                      Obx(
                        () => Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: AppColors.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: DropdownButton(
                            items: List<DropdownMenuItem<String>>.from(
                              controller.currentStatusOptions
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                            ),
                            value: controller.selectedCurrentStatus.value,
                            onChanged: (val) {
                              controller.isProfileChanged = true;
                              controller.currentStatusOtherController.clear();
                              controller.selectedCurrentStatus.value = val!;
                            },
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            padding: EdgeInsets.symmetric(
                              horizontal: 18.w,
                              vertical: 5.h,
                            ),
                            underline: const SizedBox(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: CustomButton(
                  onPressed: () {
                    // controller.callUpdate();
                  },
                  text: "Save",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.r),
          topRight: Radius.circular(28.r),
        ),
      ),
      backgroundColor: AppColors.whiteColor,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              height: 31.h,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.r),
                  topRight: Radius.circular(28.r),
                ),
              ),
              child: Center(
                child: Container(
                  width: 36.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
            ),
            Container(
              color: AppColors.whiteColor,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.h),
                  Text(
                    'Photo',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    // onTap: () => controller.setImage(0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.camera_alt,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(width: 20.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Take a Photo',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Text(
                              'Click image from your phone',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    // onTap: () => controller.setImage(1),
                    child: Row(
                      children: [
                        const Icon(Icons.image, color: AppColors.primaryColor),
                        SizedBox(width: 20.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'From Gallery',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Text(
                              'Select image from gallery',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// ignore: must_be_immutable
class PrivacyDropDown extends StatelessWidget {
  String text;
  Function(String?)? onChanged;
  PrivacyDropDown({
    super.key,
    required this.controller,
    required this.text,
    required this.onChanged,
  });

  final EditProfileController controller;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isDense: true,
      isExpanded: true,
      items: List<DropdownMenuItem<String>>.from(
        controller.visibilityOptions
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
      ),
      value: text,
      onChanged: onChanged,
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Colors.white,
        size: 20.sp,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      underline: const SizedBox(),
      selectedItemBuilder: (context) {
        final List<DropdownMenuItem<String>> list = [];
        for (int i = 0; i < controller.visibilityOptions.length; i++) {
          list.add(
            DropdownMenuItem<String>(
              value: text,
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            ),
          );
        }
        return list;
      },
    );
  }
}

class TitleText extends StatelessWidget {
  final String text;
  const TitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryColor,
      ),
    );
  }
}

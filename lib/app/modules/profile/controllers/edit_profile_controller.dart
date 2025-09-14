import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:health_parliament/app/data/models/local_profile_model.dart';
// import 'package:health_parliament/app/modules/profile/controllers/profile_controller.dart';
// import 'package:health_parliament/app/modules/profile/services/profile_services.dart';
// import 'package:health_parliament/app/utils/local_storage.dart';
// import 'package:health_parliament/app/utils/ServexUtils.dart';

class EditProfileController extends GetxController {
  // LocalProfileModel userData = Get.arguments as LocalProfileModel;
  bool isProfileChanged = false;

  final List<String> prefixDropdownItems = [
    'Dr.',
    'Mr.',
    'Mrs.',
    'Ms.',
    'Prof.',
  ];

  final List<String> genderDropdownItems = ['Male', 'Female', 'Other'];
  final List<String> visibilityOptions = ['Everyone', 'My followers', 'No one'];

  final List<String> currentStatusOptions = [
    'Student',
    'Doctor',
    'Dentist',
    'Nurse',
    'Allied Health Professional',
    'Alternative and Complementary Medicing Practitioner',
    'Mental Health Professional',
    'Administrative and Healthcare Management Professional',
    'Public Health Professional',
    'Healthcare Journalist',
    'Corporate Professional',
    'Policymaker of Government Official',
    'Entrepreneur',
    'Investor',
    'Other',
  ];

  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController currentStatusOtherController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  RxBool loading = false.obs;

  RxString selectedGender = 'Ma;e'.obs;
  Rx<DateTime?> selectedDOB = DateTime.now().obs;
  RxString selectedPrefixTitle = 'Mr.'.obs;
  RxString selectedCountry = 'India'.obs;
  RxString selectedCurrentStatus = 'Student'.obs;
  RxString selectedPhoneCode = '+91'.obs;
  RxString image = ''.obs;
  RxString genderPrivacy = 'Everyone'.obs;
  RxString contactPrivacy = 'Everyone'.obs;
  RxString emailPrivacy = 'Everyone'.obs;
  RxString dobPrivacy = 'Everyone'.obs;
  RxInt imageStatus = 0.obs;
  File galleryImage = File("");
  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    currentStatusOtherController.dispose();
    cityController.dispose();
    contactController.dispose();
    emailController.dispose();
    super.dispose();
  }

  // setImage(int type) async {
  //   isProfileChanged = true;
  //   if (type == 1) {
  //     File pickedImage =
  //         await ServexUtils.pickeImageFromGallery() ?? galleryImage;
  //     galleryImage =
  //         await ServexUtils().getCroppedFile(pickedImage) ?? galleryImage;
  //   } else {
  //     File pickedImage = await ServexUtils.pickeImageFromCamera() ?? galleryImage;
  //     galleryImage =
  //         await ServexUtils().getCroppedFile(pickedImage) ?? galleryImage;
  //   }
  //   if (galleryImage.path.isNotEmpty) {
  //     imageStatus.value = 2;
  //   } else {
  //     if (userData.img != null) {
  //       imageStatus.value = 1;
  //     } else {
  //       imageStatus.value = 0;
  //     }
  //   }

  //   Get.back();
  // }

  // @override
  // void onInit() {
  //   super.onInit();
  //   image.value = userData.img ?? "";
  //   firstNameController.text = userData.firstName;
  //   middleNameController.text = userData.middleName ?? "";
  //   lastNameController.text = userData.lastName;
  //   phoneController.text = userData.phone;
  //   emailController.text = userData.email;
  //   image.value = userData.img ?? "";
  //   selectedPrefixTitle.value = userData.prefix;
  //   selectedGender.value = userData.gender;
  //   selectedPhoneCode.value = userData.phoneCode;

  //   selectedCurrentStatus.value = userData.currentStatus;
  //   cityController.text = userData.city;
  //   contactController.text = userData.phone;
  //   selectedCountry.value = userData.country;
  //   selectedDOB.value = DateTime.parse(userData.dob);
  //   genderPrivacy.value = visibilityOptions[userData.genderVisibility];
  //   contactPrivacy.value = visibilityOptions[userData.phoneVisibility];
  //   emailPrivacy.value = visibilityOptions[userData.emailVisibility];
  //   dobPrivacy.value = visibilityOptions[userData.dobVisibility];
  //   if (userData.img != null) {
  //     imageStatus.value = 1;
  //   }
  // }

  // callUpdate() async {
  //   if (key.currentState!.validate()) {
  //     ServexUtils.showOverlayLoadingDialog();
  //     loading.value = true;
  //     String id = await LocalStorage().getUserID() ?? "";
  //     Map<String, dynamic> updatedData = {
  //       "prefix": selectedPrefixTitle.value,
  //       "firstName": firstNameController.text,
  //       "middleName": middleNameController.text,
  //       "lastName": lastNameController.text,
  //       "city": cityController.text,
  //       "country": selectedCountry.value,
  //       "gender": genderDropdownItems.indexOf(selectedGender.value) + 1,
  //       "genderVisibility": visibilityOptions.indexOf(genderPrivacy.value),
  //       "dob": DateFormat('yyyy-MM-dd').format(selectedDOB.value!),
  //       "dobVisibility": visibilityOptions.indexOf(dobPrivacy.value),
  //       "phoneCode": selectedPhoneCode.value,
  //       "phone": phoneController.text,
  //       "phoneVisibility": visibilityOptions.indexOf(contactPrivacy.value),
  //       "email": emailController.text,
  //       "emailVisibility": visibilityOptions.indexOf(emailPrivacy.value),
  //       "currentStatus": selectedCurrentStatus.value
  //     };

  //     await ProfileServices.updateProfile(
  //         id, updatedData, imageStatus.value != 1 ? galleryImage : null);
  //     loading.value = false;

  //     ServexUtils.hideOverlayLoadingDialog();
  //     Get.find<ProfileController>().updateProfileWithApi();
  //     Get.back();
  //   }
  // }
}

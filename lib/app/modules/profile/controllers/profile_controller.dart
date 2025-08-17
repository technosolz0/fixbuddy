// import 'package:fixbuddy/app/utils/local_storage.dart';
// import 'package:get/get.dart';
// import 'package:fixbuddy/app/data/models/user_cached_model.dart';
// import 'dart:convert';

// class ProfileController extends GetxController {
//   var username = 'Guest'.obs;
//   var mobile = '';
//   var email = '';
//   var address = 'No Address Provided'.obs;

//   final RxInt selectedIndex = 0.obs;

//   final LocalStorage _localStorage = LocalStorage();

//   @override
//   void onInit() {
//     super.onInit();
//     loadUserFromCache();
//   }

//   void loadUserFromCache() async {
//     String? userJson = await _localStorage.pref.read(
//       key: _localStorage.userDetailsKey,
//     );

//     if (userJson!.isNotEmpty) {
//       final user = UserCachedModel.fromJSON(jsonDecode(userJson));
//       username.value = user.fullName;

//       // location.value = user.address ?? 'No Address Provided';
//     }
//   }

//   void changeTab(int index) {
//     selectedIndex.value = index;
//   }
// }

import 'dart:convert';

import 'package:fixbuddy/app/data/models/user_cached_model.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var username = 'Guest'.obs;
  var mobile = ''.obs;
  var email = ''.obs;
  var address = 'No Address Provided'.obs;
  var image = ''.obs;

  final RxInt selectedIndex = 0.obs;

  final LocalStorage _localStorage = LocalStorage();

  @override
  void onInit() {
    super.onInit();
    loadUserFromCache();
  }

  void loadUserFromCache() async {
    String? userJson = await _localStorage.pref.read(
      key: _localStorage.userDetailsKey,
    );

    if (userJson != null && userJson.isNotEmpty) {
      final user = UserCachedModel.fromJSON(jsonDecode(userJson));
      username.value = user.fullName!;
      email.value = user.email!;
      mobile.value = user.mobile!;
      address.value = user.address ?? 'No Address Provided';
      image.value = user.image ?? '';
    }
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}

import 'dart:convert';

import 'package:fixbuddy/app/data/models/user_cached_model.dart';
import 'package:fixbuddy/app/modules/address/models/address_model.dart';
import 'package:fixbuddy/app/modules/address/services/address_service.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:fixbuddy/app/utils/servex_utils.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var username = 'Guest'.obs;
  var mobile = ''.obs;
  var email = ''.obs;
  var address = 'No Address Provided'.obs;
  var image = ''.obs;
  var alladdresses = <AddressModel>[].obs;

  final RxInt selectedIndex = 0.obs;

  final LocalStorage _localStorage = LocalStorage();
  final AddressApiService apiService = AddressApiService();

  @override
  void onInit() {
    super.onInit();
    loadUserFromCache();
    fetchAddresses();
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

  Future<void> fetchAddresses() async {
    try {
      final result = await apiService.fetchAddresses();
      if (result.statusCode == 200) {
        alladdresses.value = result.data;

        // find default address
        final defaultAddress = alladdresses.firstWhereOrNull(
          (a) => a.isDefault,
        );

        if (defaultAddress != null) {
          address.value =
              "${defaultAddress.address}, ${defaultAddress.city}, ${defaultAddress.state}, ${defaultAddress.country} - ${defaultAddress.pinCode}";
        }
        ServexUtils.dPrint("Default address: ${address.value}");
      } else {
        Get.snackbar("Error", "Failed to load addresses: ${result.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load addresses");
      ServexUtils.dPrint("fetchAddresses error: $e");
    }
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}

import 'package:get/get.dart';

class WalletController extends GetxController {
  // User details
  var username = 'aamir'.obs;
  var location = 'Jivdani road Virar East-Virar-Maharashtra'.obs;

  // Optional: BottomNavigationBar index

  final RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // You can fetch user data from API or storage here later
  }

  @override
  void onReady() {
    super.onReady();
    // Called when view is rendered
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Method to update selected tab (optional use)
  void changeTab(int index) {
    selectedIndex.value = index;
  }
}

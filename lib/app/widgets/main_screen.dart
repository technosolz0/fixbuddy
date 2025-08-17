import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fixbuddy/app/modules/booking/views/booking_view.dart';
import 'package:fixbuddy/app/modules/home/controllers/home_controller.dart';
import 'package:fixbuddy/app/modules/home/views/home_view.dart';
import 'package:fixbuddy/app/modules/profile/views/profile_view.dart';
import 'package:fixbuddy/app/modules/wallet/views/wallet_view.dart';
import 'package:fixbuddy/app/widgets/bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final HomeController controller = Get.put(HomeController());
  final RxInt selectedIndex = 0.obs;

  final List<Widget> screens = [
    HomeView(),
    const BookingView(),
    const WalletView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.grayColor,
      body: Obx(() => screens[selectedIndex.value]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CustomBottomNavBar(
          selectedIndex: selectedIndex,
          onTap: (index) {
            selectedIndex.value = index;
          },
        ),
      ),
    );
  }
}

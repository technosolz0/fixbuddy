// ignore_for_file: avoid_print

import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/modules/settings/controllers/setting_controller.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/widgets/customListTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Initialize or find SettingController
    final controller = Get.isRegistered<SettingController>()
        ? Get.find<SettingController>()
        : Get.put(SettingController());

    void showLogoutConfirmationDialog() {
      Get.dialog(
        AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                controller.logout();
                Get.back();
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      floatingActionButton: AnimatedScale(
        scale: 1.0,
        duration: const Duration(milliseconds: 300),
        child: FloatingActionButton(
          onPressed: () {
            print('Save Settings tapped');
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, AppColors.secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10.r,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.save, color: Colors.white, size: 28),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Fixed header
            SizedBox(
              height: size.height * 0.1,
              child: Stack(
                children: [
                  // Wave header
                  ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      height: size.height * 0.15,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor.withOpacity(0.9),
                            AppColors.secondaryColor.withOpacity(0.85),
                            AppColors.whiteColor.withOpacity(0.3),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                  // User name
                  Positioned(
                    top: 20.h,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                            shadows: [
                              Shadow(
                                color: Colors.white.withOpacity(0.8),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Back button
                  Positioned(
                    top: 10.h,
                    left: 10.w,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.blackColor,
                        size: 28,
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.mainScreen);
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Scrollable settings list
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    children: [
                      SettingCard(
                        title: 'Account',
                        children: [
                          CustomListTile(
                            leading: Icon(Icons.lock_outline),
                            title: Text(
                              'Change Password',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ),
                            onTap: () => controller.goToChangePass(),
                            backgroundColor: Colors.white,
                            borderRadius: 0,
                          ),
                        ],
                      ),
                      SettingCard(
                        title: 'Support',
                        children: [
                          CustomListTile(
                            leading: Icon(Icons.help_outline),
                            title: Text(
                              'Help Center',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ),
                            onTap: () => controller.goToHelpCenter(),
                            backgroundColor: Colors.white,
                            borderRadius: 0,
                          ),
                          CustomListTile(
                            leading: Icon(Icons.email_outlined),
                            title: Text(
                              'Contact Us',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                              ),
                            ),
                            trailing: Text(
                              'support@fixbuddy.com',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            ),
                            onTap: () => launchUrl(
                              Uri.parse('mailto:support@fixbuddy.com'),
                              mode: LaunchMode.externalApplication,
                            ),
                            backgroundColor: Colors.white,
                            borderRadius: 0,
                          ),
                          CustomListTile(
                            leading: Icon(Icons.feedback_outlined),
                            title: Text(
                              'Feedback',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ),
                            onTap: () {
                              print('Feedback tapped');
                              // Implement feedback bottom sheet
                            },
                            backgroundColor: Colors.white,
                            borderRadius: 0,
                          ),
                          CustomListTile(
                            leading: Icon(Icons.star_outline),
                            title: Text(
                              'Rate Us',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ),
                            onTap: () {
                              print('Rate Us tapped');
                              // Implement rate us dialog
                            },
                            backgroundColor: Colors.white,
                            borderRadius: 0,
                          ),
                        ],
                      ),
                      SettingCard(
                        title: 'About',
                        children: [
                          CustomListTile(
                            leading: Icon(Icons.person_add),
                            title: Text(
                              'Refer a Friend',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ),
                            onTap: () => controller.referFriend(),
                            backgroundColor: Colors.white,
                            borderRadius: 0,
                          ),
                          CustomListTile(
                            leading: Icon(Icons.description_outlined),
                            title: Text(
                              'Terms & Conditions',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ),
                            onTap: () => launchUrl(
                              Uri.parse('https://fixbuddy.com/terms'),
                              mode: LaunchMode.externalApplication,
                            ),
                            backgroundColor: Colors.white,
                            borderRadius: 0,
                          ),
                          CustomListTile(
                            leading: Icon(Icons.privacy_tip_outlined),
                            title: Text(
                              'Privacy Policy',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ),
                            onTap: () => launchUrl(
                              Uri.parse('https://fixbuddy.com/privacy'),
                              mode: LaunchMode.externalApplication,
                            ),
                            backgroundColor: Colors.white,
                            borderRadius: 0,
                          ),
                          CustomListTile(
                            leading: const Icon(Icons.delete_outline),
                            title: Text(
                              'Request Account Deletion',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ),
                            onTap: () {
                              print('Request Account Deletion tapped');
                              // Implement account deletion dialog
                            },
                            backgroundColor: Colors.white,
                            borderRadius: 0,
                          ),
                          Obx(
                            () => CustomListTile(
                              leading: Icon(Icons.info_outline),
                              title: Text(
                                'Version',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackColor,
                                ),
                              ),
                              trailing: Text(
                                'v${controller.appVersion.value}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              onTap: () {},
                              backgroundColor: Colors.white,
                              borderRadius: 0,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 50.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 6.r,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: CustomListTile(
                          leading: Icon(Icons.logout),
                          title: Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackColor,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          onTap: showLogoutConfirmationDialog,
                          backgroundColor: Colors.white,
                          borderRadius: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingCard({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 14.h, top: 22.h, left: 20.w),
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ...List.generate(
          children.length,
          (index) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 6.r,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: children[index],
          ),
        ),
      ],
    );
  }
}

// Custom clipper for wave-shaped header
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40.h);
    path.quadraticBezierTo(
      size.width / 4,
      size.height,
      size.width / 2,
      size.height - 20.h,
    );
    path.quadraticBezierTo(
      3 * size.width / 4,
      size.height - 40.h,
      size.width,
      size.height - 20.h,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

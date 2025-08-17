// // ignore_for_file: avoid_print

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:fixbuddy/app/constants/app_color.dart';
// import 'package:fixbuddy/app/data/models/user_cached_model.dart';
// import 'package:fixbuddy/app/data/models/user_model.dart';
// import 'package:fixbuddy/app/routes/app_routes.dart';
// import 'package:fixbuddy/app/widgets/customListTile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class ProfileView extends StatelessWidget {
//   const ProfileView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         floatingActionButton: AnimatedScale(
//           scale: 1.0,
//           duration: const Duration(milliseconds: 300),
//           child: FloatingActionButton(
//             onPressed: () {
//               print('Edit Profile tapped');
//             },
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [AppColors.primaryColor, AppColors.secondaryColor],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.3),
//                     blurRadius: 10.r,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: const Icon(Icons.edit, color: Colors.white, size: 28),
//             ),
//           ),
//         ),
//         body: SafeArea(
//           child: Column(
//             children: [
//               // Fixed header
//               Container(
//                 height: size.height * 0.3,
//                 child: Stack(
//                   children: [
//                     // Wave header
//                     ClipPath(
//                       clipper: WaveClipper(),
//                       child: Container(
//                         height: size.height * 0.25,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               AppColors.primaryColor.withOpacity(0.9),
//                               AppColors.secondaryColor.withOpacity(0.85),
//                               AppColors.whiteColor.withOpacity(0.3),
//                             ],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Profile image and name
//                     Positioned(
//                       top: 20.h,
//                       left: 0,
//                       right: 0,
//                       child: Column(
//                         children: [
//                           AnimatedContainer(
//                             duration: const Duration(milliseconds: 500),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 color: AppColors.whiteColor,
//                                 width: 4.w,
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.3),
//                                   blurRadius: 12.r,
//                                   offset: const Offset(0, 6),
//                                 ),
//                               ],
//                             ),
//                             child: controller.image.isEmpty
//                                 ? Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey[200],
//                                       shape: BoxShape.circle,
//                                     ),
//                                     height: 100.h,
//                                     width: 100.w,
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       '${controller.name.isNotEmpty ? controller.name[0] : 'U'}',
//                                       style: TextStyle(
//                                         color: AppColors.primaryColor,
//                                         fontSize: 40.sp,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   )
//                                 : CircleAvatar(
//                                     backgroundColor: Colors.grey,
//                                     backgroundImage: CachedNetworkImageProvider(
//                                       controller.image,
//                                     ),
//                                     radius: 50.r,
//                                   ),
//                           ),
//                           SizedBox(height: 8.h),
//                           Text(
//                             controller.name,
//                             style: TextStyle(
//                               fontSize: 22.sp,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.blackColor,
//                               shadows: [
//                                 Shadow(
//                                   color: Colors.white.withOpacity(0.8),
//                                   blurRadius: 4,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Settings button
//                     Positioned(
//                       top: 10.h,
//                       right: 10.w,
//                       child: IconButton(
//                         icon: const Icon(
//                           Icons.settings,
//                           color: AppColors.blackColor,
//                           size: 28,
//                         ),
//                         onPressed: () {
//                           Get.toNamed(Routes.setting);
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // Fixed TabBar
//               Container(
//                 color: AppColors.whiteColor,
//                 child: TabBar(
//                   labelColor: AppColors.primaryColor,
//                   unselectedLabelColor: Colors.grey,
//                   indicatorColor: AppColors.primaryColor,
//                   labelStyle: TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   tabs: const [
//                     Tab(text: 'Personal'),
//                     Tab(text: 'Bank'),
//                     Tab(text: 'Docs'),
//                   ],
//                 ),
//               ),
//               // Scrollable TabBarView content
//               Expanded(
//                 child: RefreshIndicator(
//                   onRefresh: () async {
//                     await Future.delayed(const Duration(seconds: 1));
//                   },
//                   child: TabBarView(
//                     children: [
//                       // Personal Info
//                       SingleChildScrollView(
//                         physics: const BouncingScrollPhysics(),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 16.w,
//                             vertical: 20.h,
//                           ),
//                           child: Column(
//                             children: [
//                               _buildInfoTile(
//                                 icon: Icons.person,
//                                 title: 'Full Name',
//                                 value: controller.fullName,
//                               ),
//                               _buildInfoTile(
//                                 icon: Icons.email,
//                                 title: 'Email',
//                                 value: controller.email,
//                               ),
//                               _buildInfoTile(
//                                 icon: Icons.phone,
//                                 title: 'Mobile',
//                                 value: controller.mobile,
//                               ),
//                               _buildInfoTile(
//                                 icon: Icons.work,
//                                 title: 'Designation',
//                                 value: controller.designation,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       // Bank Details (Placeholder)
//                       SingleChildScrollView(
//                         physics: const BouncingScrollPhysics(),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 16.w,
//                             vertical: 20.h,
//                           ),
//                           child: Column(
//                             children: [
//                               _buildInfoTile(
//                                 icon: Icons.account_balance,
//                                 title: 'Account Holder',
//                                 value: 'Not provided',
//                               ),
//                               _buildInfoTile(
//                                 icon: Icons.credit_card,
//                                 title: 'Account Number',
//                                 value: 'Not provided',
//                               ),
//                               _buildInfoTile(
//                                 icon: Icons.code,
//                                 title: 'IFSC Code',
//                                 value: 'Not provided',
//                               ),
//                               _buildInfoTile(
//                                 icon: Icons.payment,
//                                 title: 'UPI ID',
//                                 value: 'Not provided',
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       // Documents (Placeholder)
//                       SingleChildScrollView(
//                         physics: const BouncingScrollPhysics(),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 16.w,
//                             vertical: 20.h,
//                           ),
//                           child: Column(
//                             children: [
//                               _buildInfoTile(
//                                 icon: Icons.badge,
//                                 title: 'Identity Document',
//                                 value: 'Not provided',
//                               ),
//                               _buildInfoTile(
//                                 icon: Icons.account_balance_wallet,
//                                 title: 'Bank Document',
//                                 value: 'Not provided',
//                               ),
//                               _buildInfoTile(
//                                 icon: Icons.home,
//                                 title: 'Address Document',
//                                 value: 'Not provided',
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoTile({
//     required IconData icon,
//     required String title,
//     required String value,
//   }) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       margin: EdgeInsets.symmetric(vertical: 8.h),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.shade200,
//             blurRadius: 6.r,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: CustomListTile(
//         leading: Icon(icon, size: 24.sp, color: AppColors.primaryColor),
//         title: Text(
//           title,
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w600,
//             color: AppColors.blackColor,
//           ),
//         ),
//         subtitle: Text(
//           value.isEmpty ? 'Not provided' : value,
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w400,
//             color: Colors.grey.shade700,
//           ),
//         ),
//         trailing: Icon(
//           Icons.arrow_forward_ios,
//           size: 16.sp,
//           color: AppColors.primaryColor,
//         ),
//         onTap: () {
//           print('$title tapped: $value');
//         },
//         backgroundColor: Colors.transparent,
//         borderRadius: 12.r,
//       ),
//     );
//   }
// }

// // Custom clipper for wave-shaped header
// class WaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.lineTo(0, size.height - 40.h);
//     path.quadraticBezierTo(
//       size.width / 4,
//       size.height,
//       size.width / 2,
//       size.height - 20.h,
//     );
//     path.quadraticBezierTo(
//       3 * size.width / 4,
//       size.height - 40.h,
//       size.width,
//       size.height - 20.h,
//     );
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/data/models/user_model.dart';
import 'package:fixbuddy/app/modules/profile/controllers/profile_controller.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/widgets/customListTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: AnimatedScale(
          scale: 1.0,
          duration: const Duration(milliseconds: 300),
          child: FloatingActionButton(
            onPressed: () {
              print('Edit Profile tapped');
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
              child: const Icon(Icons.edit, color: Colors.white, size: 28),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Fixed header
              Container(
                height: size.height * 0.3,
                child: Stack(
                  children: [
                    // Wave header
                    ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        height: size.height * 0.25,
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
                    // Profile image and name
                    Positioned(
                      top: 20.h,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.whiteColor,
                                width: 4.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 12.r,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: controller.image.isEmpty
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      shape: BoxShape.circle,
                                    ),
                                    height: 100.h,
                                    width: 100.w,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${controller.username.value.isNotEmpty ? controller.username.value[0] : 'U'}',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 40.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    backgroundImage: CachedNetworkImageProvider(
                                      controller.image.value,
                                    ),
                                    radius: 50.r,
                                  ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            controller.username.value,
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
                    // Settings button
                    Positioned(
                      top: 10.h,
                      right: 10.w,
                      child: IconButton(
                        icon: const Icon(
                          Icons.settings,
                          color: AppColors.blackColor,
                          size: 28,
                        ),
                        onPressed: () {
                          Get.toNamed(Routes.setting);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Fixed TabBar
              Container(
                color: AppColors.whiteColor,
                child: TabBar(
                  labelColor: AppColors.primaryColor,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: AppColors.primaryColor,
                  labelStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: const [
                    Tab(text: 'Personal'),
                    Tab(text: 'Bank'),
                    Tab(text: 'Docs'),
                  ],
                ),
              ),
              // Scrollable TabBarView content
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 1));
                  },
                  child: TabBarView(
                    children: [
                      // Personal Info
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 20.h,
                          ),
                          child: Column(
                            children: [
                              _buildInfoTile(
                                icon: Icons.person,
                                title: 'Full Name',
                                value: controller.username.value,
                              ),
                              _buildInfoTile(
                                icon: Icons.email,
                                title: 'Email',
                                value: controller.email.value,
                              ),
                              _buildInfoTile(
                                icon: Icons.phone,
                                title: 'Mobile',
                                value: controller.mobile.value,
                              ),
                              _buildInfoTile(
                                icon: Icons.work,
                                title: 'Designation',
                                value: controller.address.value,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Bank Details (Placeholder)
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 20.h,
                          ),
                          child: Column(
                            children: [
                              _buildInfoTile(
                                icon: Icons.account_balance,
                                title: 'Account Holder',
                                value: 'Not provided',
                              ),
                              _buildInfoTile(
                                icon: Icons.credit_card,
                                title: 'Account Number',
                                value: 'Not provided',
                              ),
                              _buildInfoTile(
                                icon: Icons.code,
                                title: 'IFSC Code',
                                value: 'Not provided',
                              ),
                              _buildInfoTile(
                                icon: Icons.payment,
                                title: 'UPI ID',
                                value: 'Not provided',
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Documents (Placeholder)
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 20.h,
                          ),
                          child: Column(
                            children: [
                              _buildInfoTile(
                                icon: Icons.badge,
                                title: 'Identity Document',
                                value: 'Not provided',
                              ),
                              _buildInfoTile(
                                icon: Icons.account_balance_wallet,
                                title: 'Bank Document',
                                value: 'Not provided',
                              ),
                              _buildInfoTile(
                                icon: Icons.home,
                                title: 'Address Document',
                                value: 'Not provided',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CustomListTile(
        leading: Icon(icon, size: 24.sp, color: AppColors.primaryColor),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
        ),
        subtitle: Text(
          value.isEmpty ? 'Not provided' : value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade700,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.sp,
          color: AppColors.primaryColor,
        ),
        onTap: () {
          print('$title tapped: $value');
        },
        backgroundColor: Colors.transparent,
        borderRadius: 12.r,
      ),
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

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:lifetrackr/app/common_widgets/custom_filled_button.dart';
// import 'package:lifetrackr/app/utils/constants/asset_constants.dart';
// import 'package:lifetrackr/app/utils/extensions.dart';
// import 'package:lifetrackr/app/utils/theme.dart';
// import 'package:lifetrackr/app/utils/utilities.dart';

// Future showHealthNotInstalled() async {
//   await showDialog(
//       context: Get.context!,
//       builder: (context) {
//         return Dialog(
//           insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 22.h),
//             decoration: BoxDecoration(
//                 color: context.isLightTheme
//                     ? ThemeClass.cardLightColor
//                     : ThemeClass.cardColor,
//                 borderRadius: BorderRadius.circular(16.r)),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: GestureDetector(
//                     onTap: () {
//                       Get.back();
//                     },
//                     child: Container(
//                       width: 32.w,
//                       height: 32.w,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Color(0xffC72B31),
//                       ),
//                       child: Center(
//                         child: Icon(
//                           Icons.close,
//                           color: Colors.white,
//                           size: 20.sp,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Image.asset(
//                   AssetConstants.healthConnectIcon,
//                   width: 99.w,
//                 ),
//                 SizedBox(height: 28.h),
//                 Text(
//                   context.l10n.install_health_connect,
//                   style: GothamRounded.bold(
//                     fontSize: 22.sp,
//                     color: ThemeClass.darkModeTextColor,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 16.h),
//                 Text(
//                   context.l10n.install_health_connect_msg,
//                   style: GothamRounded.book(
//                     fontSize: 14.sp,
//                     color: ThemeClass.darkModeTextColor,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 26.h),
//                 CustomFilledButton(
//                   onPressed: () {
//                     Utilities.launchUrlFromApp(
//                         'https://play.google.com/store/apps/details?id=com.google.android.apps.healthdata&hl=en_IN&pli=1');
//                     Get.back();
//                   },
//                   child: Wrap(
//                     children: [
//                       Image.asset(
//                         AssetConstants.playStoreIcon,
//                         width: 20.w,
//                         height: 20.w,
//                       ),
//                       SizedBox(width: 10.w),
//                       Text(
//                         context.l10n.download_from_playstore,
//                         style: GothamRounded.medium(
//                           fontSize: 14.sp,
//                           color: ThemeClass.darkModeTextColor,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       });
// }

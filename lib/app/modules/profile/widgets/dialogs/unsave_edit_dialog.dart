// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:health_parliament/app/common_widgets/custom_filled_button.dart';
// import 'package:health_parliament/app/utils/constants.dart';
// import 'package:health_parliament/app/utils/theme.dart';

// Future showUnsavedEditDialog() async {
//   await showDialog(
//       context: Get.context!,
//       builder: (_) {
//         return Dialog(
//           insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
//             decoration: BoxDecoration(
//                 color: ThemeClass.whiteColor,
//                 borderRadius: BorderRadius.circular(16.r)),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Image.asset(
//                       AssetsConstants.discard,
//                       width: 20.w,
//                       height: 20.h,
//                     ),
//                     SizedBox(
//                       width: 10.w,
//                     ),
//                     Text(
//                       "Discard Changes?",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: ThemeClass.primaryColor,
//                           fontSize: 22.sp),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 18.h,
//                 ),
//                 Text(
//                   'You have unsaved changes. If you proceed, all your edits will be lost.',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w400,
//                       color: ThemeClass.blackColor,
//                       fontSize: 16.sp),
//                 ),
//                 SizedBox(
//                   height: 22.h,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     SizedBox(
//                       width: 140.h,
//                       child: CustomFilledButton(
//                         onPressed: () {
//                           Get.back();
//                         },
//                         text: "Cancel",
//                         textColor: ThemeClass.blackColor,
//                         bgColor: ThemeClass.ffe1e9eb,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 140.h,
//                       child: CustomFilledButton(
//                         onPressed: () {
//                           Get.back();
//                           Get.back();
//                         },
//                         text: "Discard",
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       });
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:fixbuddy/app/utils/extensions.dart';

// showDeleteAccountDialog(BuildContext context) {
//   TextEditingController accountDeletionReasonController =
//       TextEditingController();
//   showDialog(
//       context: context,
//       builder: (_) {
//         return Dialog(
//           insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
//           child: Container(
//             decoration: BoxDecoration(
//                 color: context.isLightTheme
//                     ? ThemeClass.cardLightColor
//                     : ThemeClass.cardColor,
//                 borderRadius: BorderRadius.circular(16.r)),
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         AssetConstants.deleteBinIcon,
//                         width: 24.w,
//                         height: 24.w,
//                       ),
//                       SizedBox(
//                         width: 16.w,
//                       ),
//                       Text(
//                         context.l10n.delete_account,
//                         style: GothamRounded.semiBold(
//                             fontSize: 24.sp,
//                             color: ThemeClass.darkModeTextColor),
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: 22.h,
//                   ),
//                   Text(
//                     context.l10n.delete_account_message,
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w500,
//                       color: ThemeClass.whiteColor,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 24.h,
//                   ),
//                   CustomTextformField(
//                     maxL: 3,
//                     controller: accountDeletionReasonController,
//                     name: context.l10n.reason,
//                     maxLength: 1000,
//                   ),
//                   SizedBox(
//                     height: 28.h,
//                   ),
//                   Row(
//                     children: [
//                       SizedBox(
//                         width: 140.w,
//                         child: CustomFilledButton(
//                           onPressed: () {
//                             Get.back();
//                           },
//                           text: context.l10n.cancel,
//                           isOutlined: true,
//                           borderColor: Colors.white,
//                         ),
//                       ),
//                       const Spacer(),
//                       SizedBox(
//                         width: 140.w,
//                         child: CustomFilledButton(
//                           onPressed: () async {
//                             if (accountDeletionReasonController.text
//                                 .trim()
//                                 .isEmpty) {
//                               Utilities.showSnackbar(SnackType.INFO,
//                                   context.l10n.input_cannot_be_empty);
//                               return;
//                             }
//                             Get.back();
//                             Utilities.showOverlayLoadingDialog();
//                             bool success = await GeneralServices()
//                                 .submitDeleteRequest(
//                                     reason: accountDeletionReasonController.text
//                                         .trim());
//                             Utilities.hideOverlayLoadingDialog();
//                             if (success) {
//                               Utilities.showSnackbar(SnackType.SUCCESS,
//                                   context.l10n.delete_request_submitted);
//                             }
//                           },
//                           text: context.l10n.submit,
//                           textStyle:
//                               TextStyle(color: Colors.white, fontSize: 16.sp),
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       }).then((_) {
//     accountDeletionReasonController.dispose();
//   });
// }

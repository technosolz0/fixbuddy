// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:lifetrackr/app/common_widgets/custom_filled_button.dart';
// import 'package:lifetrackr/app/common_widgets/custom_overlay.dart';
// import 'package:lifetrackr/app/common_widgets/custom_textformfield.dart';
// import 'package:lifetrackr/app/data/services/general_services.dart';
// import 'package:lifetrackr/app/utils/constants/asset_constants.dart';
// import 'package:lifetrackr/app/utils/extensions.dart';
// import 'package:lifetrackr/app/utils/theme.dart';
// import 'package:lifetrackr/app/utils/utilities.dart';

// showFeedbackDialog(BuildContext context) {
//   TextEditingController feedbackController = TextEditingController();
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
//                         AssetConstants.feedbackIcon,
//                         width: 24.w,
//                         height: 24.w,
//                       ),
//                       SizedBox(
//                         width: 16.w,
//                       ),
//                       Text(
//                         context.l10n.feedback,
//                         style: GothamRounded.semiBold(
//                             fontSize: 24.sp,
//                             color: ThemeClass.darkModeTextColor),
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: 24.h,
//                   ),
//                   CustomTextformField(
//                     maxL: 3,
//                     controller: feedbackController,
//                     name: context.l10n.feedback,
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
//                             if (feedbackController.text.trim().isEmpty) {
//                               Utilities.showSnackbar(SnackType.INFO,
//                                   context.l10n.input_cannot_be_empty);
//                               return;
//                             }
//                             Get.back();
//                             Utilities.showOverlayLoadingDialog();
//                             bool success = await GeneralServices()
//                                 .submitFeedback(
//                                     feedback: feedbackController.text.trim());
//                             Utilities.hideOverlayLoadingDialog();
//                             if (success) {
//                               Utilities.showSnackbar(SnackType.SUCCESS,
//                                   context.l10n.feedback_submitted_msg);
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
//     feedbackController.dispose();
//   });
// }

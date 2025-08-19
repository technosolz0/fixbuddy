// // ignore_for_file: use_build_context_synchronously

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:get/get.dart' as getx;
// import 'package:fixbuddy/app/constants/app_constants.dart';
// import 'package:fixbuddy/app/constants/custom_overlay.dart';
// import 'package:fixbuddy/app/constants/dialogs/show_simple_dialog.dart';
// import 'package:fixbuddy/app/data/models/user_model.dart';
// import 'package:fixbuddy/app/utils/extensions.dart';
// import 'package:fixbuddy/app/utils/local_storage.dart';
// import 'package:fixbuddy/app/utils/network_utilities.dart';
// import 'package:fixbuddy/app/utils/servex_utils.dart';

// class GeneralServices {
//   final dio = NetworkServexUtils.getDioClient();
//   final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

//   static const String submitDeleteRequestPath = '/v1/user/request-delete';
//   static const String getUserPath = '/v1/user/list';
//   static const String getCategoriesPath = '/v1/category/list';
//   static const String updateLangPath = '/v1/user/update-lang';
//   static const String readNotificationPath = '/v1/user/read-notification';
//   static const String getUserStatusPath = '/v1/user/status';
//   static const String feedbackPath = '/v1/user/feedback';

//   /// To submit account delete request
//   Future<bool> submitDeleteRequest({required String reason}) async {
//     try {
//       String? userID = await LocalStorage().getUserID();
//       Map<String, dynamic> data = {'userId': userID ?? '', 'reason': reason};
//       Response response = await dio.post(
//         submitDeleteRequestPath,
//         data: data,
//         options: Options(headers: await NetworkServexUtils.getAuthHeader()),
//       );

//       if (response.statusCode == 200) {
//         int result = int.parse(response.data['result'].toString());
//         if (result == 1) {
//           return true;
//         } else {
//           return false;
//         }
//       } else {
//         NetworkServexUtils.handleOtherStatusCodes(
//           response.statusCode,
//           defaultMsg:
//               response.data['message'] ??
//               getx.Get.context!.l10n.something_went_wrong,
//         );
//         return false;
//       }
//     } on DioException catch (e) {
//       NetworkServexUtils.dioExceptionHandler(e);
//       ServexUtils.dPrint('--->submit delete request api error: $e');
//     }
//     return false;
//   }

//   /// To search for an organization's user by passing `query` String
//   Future<List<UserModel>> getUser({
//     required String query,
//     required int page,
//     required int records,
//   }) async {
//     try {
//       // String? userID = await LocalStorage().getUserID();
//       Map<String, dynamic> data = {
//         'userId': userID ?? '',
//         'query': query,
//         'page': page,
//         'records': records,
//       };
//       Response response = await dio.post(
//         getUserPath,
//         data: data,
//         options: Options(headers: await NetworkServexUtils.getAuthHeader()),
//       );

//       if (response.statusCode == 200) {
//         int result = int.parse(response.data['result'].toString());
//         if (result == 1) {
//           return List<Map<String, dynamic>>.from(
//             response.data['users'],
//           ).map((e) => UserModel.fromJSON(e)).toList();
//         } else {
//           return [];
//         }
//       } else {
//         NetworkServexUtils.handleOtherStatusCodes(
//           response.statusCode,
//           defaultMsg:
//               response.data['message'] ??
//               getx.Get.context!.l10n.something_went_wrong,
//         );
//         return [];
//       }
//     } on DioException catch (e) {
//       NetworkServexUtils.dioExceptionHandler(e);
//       ServexUtils.dPrint('--->fetch user list api error: $e');
//     }
//     return [];
//   }

//   /// To update user's current language
//   Future<bool> updateCurrentLanguage() async {
//     try {
//       String userID = await LocalStorage().getUserID() ?? '';
//       String lang =
//           await LocalStorage().getLanguage() ?? AppLanguage.english.locale;
//       Map<String, dynamic> data = {"userId": userID, "lang": lang};
//       Response response = await dio.post(
//         updateLangPath,
//         data: data,
//         options: Options(headers: await NetworkServexUtils.getAuthHeader()),
//       );

//       if (response.statusCode == 200) {
//         int result = int.parse(response.data['result'].toString());
//         if (result == 1) {
//           return true;
//         } else {
//           return false;
//         }
//       } else {
//         NetworkServexUtils.handleOtherStatusCodes(
//           response.statusCode,
//           defaultMsg:
//               response.data['message'] ??
//               getx.Get.context!.l10n.something_went_wrong,
//         );
//         return false;
//       }
//     } on DioException catch (e) {
//       NetworkServexUtils.dioExceptionHandler(e);
//       ServexUtils.dPrint('--->update lang api error: $e');
//     }
//     return false;
//   }

//   /// To mark a notification as read. Pass `notificationId` String
//   ///
//   /// Returns bool
//   Future<bool> readNotification({required String notificationId}) async {
//     try {
//       String userID = await LocalStorage().getUserID() ?? '';

//       Map<String, dynamic> data = {
//         'userId': userID,
//         'notificationId': notificationId,
//       };

//       Response response = await dio.post(
//         readNotificationPath,
//         data: data,
//         options: Options(headers: await NetworkServexUtils.getAuthHeader()),
//       );

//       if (response.statusCode == 200) {
//         int result = int.parse(response.data['result'].toString());
//         if (result == 1) {
//           return true;
//         } else {
//           ServexUtils.showSnackbar(
//             SnackType.error,
//             response.data['message'] ?? 'Something went wrong!',
//           );
//           return false;
//         }
//       } else {
//         NetworkServexUtils.handleOtherStatusCodes(response.statusCode);
//         return false;
//       }
//     } on DioException catch (e) {
//       NetworkServexUtils.dioExceptionHandler(e);
//       ServexUtils.dPrint('--->read notifications api error: $e');
//     }
//     return false;
//   }

//   /// To get user's current status i.e blocked or account deleted
//   ///
//   /// Returns true if everything is fine.
//   Future<bool> checkUserCurrentStatus({required String orgId}) async {
//     try {
//       String userID = await LocalStorage().getUserID() ?? '';

//       Map<String, dynamic> data = {'userId': userID, 'orgId': orgId};

//       Response response = await dio.post(
//         getUserStatusPath,
//         data: data,
//         options: Options(headers: await NetworkServexUtils.getAuthHeader()),
//       );

//       if (response.statusCode == 200) {
//         int result = int.parse(response.data['result'].toString());
//         if (result == 1) {
//           return true;
//         } else if (result == 2) {
//           BuildContext ctx = getx.Get.context!;
//           showSimpleDialog(
//             ctx,
//             ctx.l10n.account_blocked,
//             getx.Get.context!.l10n.okay,
//             desc: ctx.l10n.account_blocked_msg,
//             () {
//               getx.Get.back();
//               ServexUtils.logOut(callAPI: false);
//             },
//             canPop: false,
//           );
//         } else if (result == 3) {
//           BuildContext ctx = getx.Get.context!;
//           showSimpleDialog(
//             ctx,
//             ctx.l10n.account_deleted,
//             getx.Get.context!.l10n.okay,
//             desc: ctx.l10n.account_deleted_msg,
//             () {
//               getx.Get.back();
//               ServexUtils.logOut(callAPI: false);
//             },
//             canPop: false,
//           );
//         }
//         return false;
//       } else {
//         NetworkServexUtils.handleOtherStatusCodes(response.statusCode);
//         return false;
//       }
//     } on DioException catch (e) {
//       NetworkServexUtils.dioExceptionHandler(e);
//       ServexUtils.dPrint('--->check user status api error: $e');
//     }
//     return false;
//   }

//   /// To give user's feedback
//   Future<bool> submitFeedback({required String feedback}) async {
//     try {
//       String userID = await LocalStorage().getUserID() ?? '';

//       Map<String, dynamic> data = {'userId': userID, 'feedback': feedback};

//       Response response = await dio.post(
//         feedbackPath,
//         data: data,
//         options: Options(headers: await NetworkServexUtils.getAuthHeader()),
//       );

//       if (response.statusCode == 200) {
//         int result = int.parse(response.data['result'].toString());
//         if (result == 1) {
//           return true;
//         } else {
//           return false;
//         }
//       } else {
//         NetworkServexUtils.handleOtherStatusCodes(response.statusCode);
//         return false;
//       }
//     } on DioException catch (e) {
//       NetworkServexUtils.dioExceptionHandler(e);
//       ServexUtils.dPrint('--->submit feedback api error: $e');
//     }
//     return false;
//   }
// }

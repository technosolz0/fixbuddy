import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart' as getx;
import 'package:fixbuddy/app/constants/custom_overlay.dart';
import 'package:fixbuddy/app/data/models/user_cached_model.dart';
import 'package:fixbuddy/app/utils/extensions.dart';
import 'package:fixbuddy/app/utils/firebase_notifications.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:fixbuddy/app/utils/network_utilities.dart';
import 'package:fixbuddy/app/utils/servex_utils.dart';

class AuthServices {
  final dio = NetworkServexUtils.getDioClient();

  static const String loginPath = '/v1/auth/login';
  static const String logoutPath = '/v1/auth/logout';
  static const String updateFCMTokenPath = '/v1/user/update-fcm';
  static const String sendOTPPath = '/v1/auth/send-otp';
  static const String verifyOTPPath = '/v1/auth/verify-otp';
  static const String resetPasswordPath = '/v1/auth/reset-password';

  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future<String> _getDeviceId() async {
    String deviceId = '';
    try {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId = androidInfo.id;
    } catch (e) {
      ServexUtils.dPrint('---> Failed to get device ID: $e');
    }
    return deviceId;
  }

  /// To login user to the app. Pass `email` String, `password` String
  ///
  /// This returns a `userID` String, `isOnboarded` bool, `isBlocked` bool, `error` String
  Future<(String, bool, bool, String?)> login({
    required String email,
    required String password,
  }) async {
    try {
      String? fcmToken = await FirebaseNotifications.getFirebaseToken() ?? '';
      String deviceId = await _getDeviceId();

      Map<String, dynamic> data = {
        'email': email,
        'password': password,
        'fcmToken': fcmToken,
        'deviceId': deviceId,
      };

      Response response = await dio.post(loginPath, data: data);

      if (response.statusCode == 200) {
        int result = int.parse(response.data['result'].toString());
        if (result == 1) {
          // String userID = response.data['userId'].toString();
          bool isUserOnboarded = response.data['isOnboarded'] ?? false;
          bool isAllGoalsSetup = response.data['isAllGoalsSetup'] ?? false;
          response.data['email'] = email;
          UserCachedModel userDetails = UserCachedModel.fromJSON(response.data);

          await LocalStorage().setToken(response.data['jwtToken'].toString());
          // await LocalStorage().setUserID(userID);
          await LocalStorage().setIsOnboarded(isUserOnboarded);
          await LocalStorage().setAllGoalsProvided(isAllGoalsSetup);
          await LocalStorage().setUserDetails(userDetails);
          await LocalStorage().setLastLoginDate(DateTime.now());
          await LocalStorage().setLastFCMUpdatedAtDate(DateTime.now());
          await LocalStorage().setLastSentFCM(fcmToken);

          // return (userID, isUserOnboarded, false, null);
        } else if (result == 4) {
          return ('', false, true, response.data['message'].toString());
        } else {
          return ('', false, false, response.data['message'].toString());
        }
      } else {
        return ('', false, false, response.data['message']?.toString());
      }
    } on DioException catch (e) {
      NetworkServexUtils.dioExceptionHandler(e);
      ServexUtils.dPrint('--->login api error: $e');
    }
    return ('', false, false, null);
  }

  /// To update fcm token
  Future<void> updateFCMToken() async {
    try {
      int? userID = await LocalStorage().getUserID() ?? 0;
      String newFCMToken = await FirebaseNotifications.getFirebaseToken() ?? '';
      String deviceId = await _getDeviceId();

      Map<String, dynamic> data = {
        'userId': userID,
        'newFCMToken': newFCMToken,
        'deviceId': deviceId,
      };

      Response response = await dio.post(
        updateFCMTokenPath,
        data: data,
        options: Options(headers: await NetworkServexUtils.getAuthHeader()),
      );

      if (response.statusCode == 200) {
        int result = int.parse(response.data['result'].toString());
        if (result == 1) {
          return;
        } else {
          return;
        }
      } else {
        NetworkServexUtils.handleOtherStatusCodes(response.statusCode);
        return;
      }
    } on DioException catch (e) {
      NetworkServexUtils.dioExceptionHandler(e);
      ServexUtils.dPrint('--->update fcm token api error: $e');
    }
    return;
  }

  /// To logout user from the app. This clears user's FCM token and JWT token from the backend
  /// Returns `bool` to indicate success call
  Future<bool> logout() async {
    try {
      int userID = await LocalStorage().getUserID() ?? 0;
      String deviceId = await _getDeviceId();

      Map<String, dynamic> data = {'userId': userID, 'deviceId': deviceId};

      Response response = await dio.post(
        logoutPath,
        data: data,
        options: Options(headers: await NetworkServexUtils.getAuthHeader()),
      );

      if (response.statusCode == 200) {
        int result = int.parse(response.data['result'].toString());
        if (result == 1) {
          return true;
        } else {
          ServexUtils.showSnackbar(SnackType.error, response.data['message']);
          return false;
        }
      } else {
        NetworkServexUtils.handleOtherStatusCodes(
          response.statusCode,
          defaultMsg:
              response.data['message'] ??
              getx.Get.context!.l10n.something_went_wrong,
        );
        return false;
      }
    } on DioException catch (e) {
      NetworkServexUtils.dioExceptionHandler(e);
      ServexUtils.dPrint('--->logout api error: $e');
    }
    return false;
  }

  /// To send OTP to the user. Pass `email` String
  ///
  /// Returns `result` bool
  Future<bool> sendOTP({required String email}) async {
    try {
      Map<String, dynamic> data = {'email': email};

      Response response = await dio.post(sendOTPPath, data: data);

      if (response.statusCode == 200) {
        int result = int.parse(response.data['result'].toString());
        if (result == 1) {
          return true;
        } else {
          ServexUtils.showSnackbar(
            SnackType.error,
            response.data['message'] ??
                getx.Get.context!.l10n.something_went_wrong,
          );
          return false;
        }
      } else {
        NetworkServexUtils.handleOtherStatusCodes(
          response.statusCode,
          defaultMsg:
              response.data['message'] ??
              getx.Get.context!.l10n.something_went_wrong,
        );
        return false;
      }
    } on DioException catch (e) {
      NetworkServexUtils.dioExceptionHandler(e);
      ServexUtils.dPrint('--->send otp api error: $e');
    }
    return false;
  }

  /// To verify OTP entered by the user. Pass `email` String, `OTP` String
  Future<bool> verifyOTP({required String email, required String otp}) async {
    try {
      Map<String, dynamic> data = {'email': email, 'otp': otp};

      Response response = await dio.post(verifyOTPPath, data: data);

      if (response.statusCode == 200) {
        int result = int.parse(response.data['result'].toString());
        if (result == 1) {
          return true;
        } else {
          ServexUtils.showSnackbar(
            SnackType.error,
            response.data['message'] ??
                getx.Get.context!.l10n.something_went_wrong,
          );
          return false;
        }
      } else {
        NetworkServexUtils.handleOtherStatusCodes(
          response.statusCode,
          defaultMsg:
              response.data['message'] ??
              getx.Get.context!.l10n.something_went_wrong,
        );
        return false;
      }
    } on DioException catch (e) {
      NetworkServexUtils.dioExceptionHandler(e);
      ServexUtils.dPrint('--->verify otp api error: $e');
    }
    return false;
  }

  /// To reset password of the user. Pass `email` String, `newPassword` String
  Future<bool> resetPassword({
    required String newPassword,
    required String email,
  }) async {
    try {
      Map<String, dynamic> data = {'email': email, 'password': newPassword};

      Response response = await dio.post(resetPasswordPath, data: data);

      if (response.statusCode == 200) {
        int result = int.parse(response.data['result'].toString());
        if (result == 1) {
          await LocalStorage().setHasResetPassword(true);
          return true;
        } else {
          ServexUtils.showSnackbar(
            SnackType.error,
            response.data['message'] ??
                getx.Get.context!.l10n.something_went_wrong,
          );
          return false;
        }
      } else {
        NetworkServexUtils.handleOtherStatusCodes(
          response.statusCode,
          defaultMsg:
              response.data['message'] ??
              getx.Get.context!.l10n.something_went_wrong,
        );
        return false;
      }
    } on DioException catch (e) {
      NetworkServexUtils.dioExceptionHandler(e);
      ServexUtils.dPrint('--->reset password api error: $e');
    }
    return false;
  }
  
}

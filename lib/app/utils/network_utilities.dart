import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fixbuddy/app/constants/api_constants.dart';
import 'package:fixbuddy/app/constants/custom_overlay.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:fixbuddy/app/utils/servex_utils.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkServexUtils {
  static Dio getDioClient() {
    Dio dioClient = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        validateStatus: (status) {
          if (status == null) return false;
          return true;
        },
      ),
    );

    //Adding interceptors to log request and response data for all API calls for debugging
    dioClient.interceptors.add(
      PrettyDioLogger(
        enabled: kDebugMode,
        error: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        logPrint: (object) {
          ServexUtils.dLog(object);
        },
      ),
    );

    return dioClient;
  }

  static Future<Map<String, dynamic>> getAuthHeader() async {
    String token = await LocalStorage().getToken() ?? '';
    return {'Authorization': 'Bearer $token'};
  }

  /// exception handler to manage dio exceptions and show snackbar respectively
  static void dioExceptionHandler(DioException e) {
    String snackbarBody = 'Some error occurred.';
    switch (e.type) {
      case DioExceptionType.connectionError:
        snackbarBody =
            'No Internet. Please make sure you are connected to the Internet.';
        break;
      case DioExceptionType.badResponse:
        snackbarBody = 'Some error occurred, please try again. [Bad Response]';
        break;
      case DioExceptionType.connectionTimeout:
        snackbarBody = 'Server took too long to respond.';
        break;
      case DioExceptionType.receiveTimeout:
        snackbarBody = 'Server took too long to respond.';
        break;
      case DioExceptionType.sendTimeout:
        snackbarBody = 'Cannot connect to server at the moment.';
        break;
      default:
        snackbarBody = 'Some error occurred.';
    }

    ServexUtils.showSnackbar(SnackType.error, snackbarBody);
  }

  /// handle session expiry when jwt token is expired i.e When status code is 401
  ///
  /// Returns true if the status code was 401 and this function hadled it.
  /// A snackbar will be shown for session expiry
  static Future<void> handleOtherStatusCodes(
    int? statusCode, {
    String defaultMsg = 'Something went wrong!',
  }) async {
    if (statusCode == null) return;
    if (statusCode == 401) {
      await ServexUtils.logOut();
      ServexUtils.showSnackbar(
        SnackType.info,
        'Your session has been expired. Please login again.',
      );
    } else if (statusCode == 413) {
      ServexUtils.showSnackbar(
        SnackType.info,
        'Maximum limit reached for request.',
      );
    } else {
      ServexUtils.showSnackbar(SnackType.error, defaultMsg);
    }
  }
}

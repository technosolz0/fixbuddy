import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:fixbuddy/app/utils/servex_utils.dart';

class TestService {
  final dio = Dio(
    BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60), // 60 seconds
      receiveTimeout: const Duration(seconds: 60), // 60 seconds
      validateStatus: (status) {
        if (status == null) return false;
        return true;
      },
    ),
  );

  static const String testPath =
      'https://testadminapi.thelifetrackr.com/v1/test-dummy';

  Future<Response> test({
    Map<String, dynamic>? request,
    required Map<String, dynamic> response,
  }) async {
    dio.interceptors.add(
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
    return await dio.post(testPath, data: response);
  }
}

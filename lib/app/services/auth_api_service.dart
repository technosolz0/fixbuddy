import 'package:dio/dio.dart';
import 'package:fixbuddy/app/utils/servex_utils.dart';

class AuthApiService {
  final Dio _dio = Dio(ServexUtils.getDioOptions)
    ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

  Future<Response?> sendRegistrationOtp({
    required String name,
    required String email,
    required String mobile,
  }) async {
    try {
      final response = await _dio.post(
        '/api/users/register-otp',
        data: {'name': name, 'email': email, 'mobile': mobile},
      );
      return response;
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
      return null;
    }
  }

  Future<Response?> verifyRegistrationOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _dio.post(
        '/api/users/verify-otp',
        data: {'email': email, 'otp': otp},
      );
      return response;
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
      return null;
    }
  }

  Future<Response?> resendRegistrationOtp(String email) async {
    try {
      final response = await _dio.post(
        '/api/users/resend-otp',
        data: {'email': email},
      );
      return response;
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
      return null;
    }
  }

  Future<Response?> sendLoginOtp(String email) async {
    try {
      final response = await _dio.post(
        '/api/users/send-login-otp',
        data: {'email': email},
      );
      return response;
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
      return null;
    }
  }

  Future<Response?> verifyLoginOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _dio.post(
        '/api/users/verify-login-otp',
        data: {'email': email, 'otp': otp},
      );
      return response;
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
      return null;
    }
  }

  Future<Response?> resendLoginOtp(String email) async {
    try {
      final response = await _dio.post(
        '/api/users/resend-login-otp',
        data: {'email': email},
      );
      return response;
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
      return null;
    }
  }
}

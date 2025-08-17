import 'package:dio/dio.dart';
import 'package:fixbuddy/app/constants/api_constants.dart';

class AuthApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      validateStatus: (status) {
        // Accept all statuses below 500 as valid responses (handle 400 gracefully)
        return status! < 500;
      },
    ),
  )..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

  Future<Response> sendRegistrationOtp({
    required String name,
    required String email,
    required String mobile,
  }) async {
    return await _dio.post(
      '/api/users/register-otp',
      data: {'name': name, 'email': email, 'mobile': mobile},
    );
  }

  Future<Response> verifyRegistrationOtp({
    required String email,
    required String otp,
  }) async {
    return await _dio.post(
      '/api/users/verify-otp',
      data: {'email': email, 'otp': otp},
    );
  }

  Future<Response> resendRegistrationOtp(String email) async {
    return await _dio.post('/api/users/resend-otp', data: {'email': email});
  }

  Future<Response> sendLoginOtp(String email) async {
    return await _dio.post('/api/users/send-login-otp', data: {'email': email});
  }

  Future<Response> verifyLoginOtp({
    required String email,
    required String otp,
  }) async {
    return await _dio.post(
      '/api/users/verify-login-otp',
      data: {'email': email, 'otp': otp},
    );
  }

  Future<Response> resendLoginOtp(String email) async {
    return await _dio.post(
      '/api/users/resend-login-otp',
      data: {'email': email},
    );
  }
}

import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        final data = error.response?.data;
        if (data != null && data is Map && data.containsKey('detail')) {
          return data['detail'].toString();
        } else if (data is Map && data.containsKey('message')) {
          return data['message'].toString();
        } else {
          return 'Unexpected server response: ${error.response?.statusCode}';
        }
      } else if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return 'Request timed out. Please check your internet connection.';
      } else if (error.type == DioExceptionType.connectionError) {
        return 'Could not connect to server. Check your network.';
      } else {
        return 'Network error occurred. ${error.message}';
      }
    } else {
      return 'An unexpected error occurred. $error';
    }
  }
}

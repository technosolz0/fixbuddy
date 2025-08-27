import 'package:dio/dio.dart';
import 'package:fixbuddy/app/constants/api_constants.dart';
import 'package:fixbuddy/app/modules/booking/models/booking_model.dart';
import 'package:fixbuddy/app/modules/booking/models/payment_model.dart';
import 'package:fixbuddy/app/modules/booking/models/vendor_charge_model.dart';
import 'package:fixbuddy/app/modules/booking/models/vendor_model.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';

class BookingServices {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  final LocalStorage _localStorage = LocalStorage(); // ✅ instance

  // Add authentication token to headers
  Future<void> _addAuthHeader() async {
    String? token = await _localStorage.getToken(); // ✅ use instance
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  // Fetch vendors and charges
  Future<VendorChargeResponse> fetchVendorsAndCharges() async {
    try {
      await _addAuthHeader();
      final response = await _dio.get('/api/vendor/me');
      return VendorChargeResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // Fetch booking details by booking_id
  Future<BookingResponse> fetchBookingDetails(int bookingId) async {
    try {
      await _addAuthHeader();
      final response = await _dio.get('/api/bookings/$bookingId');
      return BookingResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // Fetch payment details by booking_id
  Future<PaymentResponse> fetchPaymentDetails(int bookingId) async {
    try {
      await _addAuthHeader();
      final response = await _dio.get('/api/bookings/$bookingId/payment');
      return PaymentResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // Fetch vendor details by vendor_id
  Future<VendorResponse> fetchVendorDetails(int vendorId) async {
    try {
      await _addAuthHeader();
      final response = await _dio.get('/api/vendor/$vendorId'); // ✅ updated
      return VendorResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // ✅ Fetch all bookings for logged-in user
  Future<List<BookingResponse>> fetchAllBookings() async {
    try {
      await _addAuthHeader();
      final response = await _dio.get(
        '/api/bookings',
      ); // Backend: returns all bookings for current user
      final List data = response.data;
      print(' Fetched bookings: $data'); // Debug log
      return data.map((json) => BookingResponse.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // Handle Dio errors
  Exception _handleDioError(DioException e) {
    if (e.response != null) {
      switch (e.response!.statusCode) {
        case 403:
          return Exception(
            'Unauthorized access: ${e.response!.data['detail']}',
          );
        case 404:
          return Exception('Not found: ${e.response!.data['detail']}');
        case 400:
          return Exception('Bad request: ${e.response!.data['detail']}');
        default:
          return Exception('Error: ${e.response!.data['detail'] ?? e.message}');
      }
    }
    return Exception('Network error: ${e.message}');
  }
}

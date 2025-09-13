
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:dio/dio.dart';

import 'package:fixbuddy/app/constants/api_constants.dart';
import 'package:fixbuddy/app/modules/allservices/services/service_service.dart';
import 'package:fixbuddy/app/modules/allservices/models/service_model.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';

class AllServicesController extends GetxController {
  final VendorApiService _apiService = VendorApiService();
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  final LocalStorage localStorage = LocalStorage();

  var isLoading = false.obs;
  var vendorResponse = Rxn<VendorChargeResponse>();
  var errorMessage = ''.obs;
  RxInt userId = 0.obs;

  int? categoryId;
  int? subCategoryId;
  late Razorpay _razorpay;

  Map<String, dynamic>? _pendingBooking;

  @override
  void onInit() {
    super.onInit();

    // Initialize arguments
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      categoryId = args['categoryId'] as int?;
      subCategoryId = args['subCategoryId'] as int?;
    }

    // Initialize Razorpay
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);

    // Load user ID and fetch vendors
    _loadUserIdAndFetchVendors();
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }

  Future<void> _loadUserIdAndFetchVendors() async {
    try {
      final idString = await localStorage.getUserID();
      userId.value = int.tryParse(idString?.toString() ?? '') ?? 0;
      if (userId.value == 0) {
        errorMessage.value = 'User ID not found. Please log in again.';
        Get.snackbar('Error', errorMessage.value);
        print('Error: $errorMessage');
        return;
      }
      print('User ID loaded: ${userId.value}');
      await fetchVendorsAndCharges();
    } catch (e) {
      errorMessage.value = 'Failed to load user ID: $e';
      Get.snackbar('Error', errorMessage.value);
      print('Error: $errorMessage');
    }
  }

  Future<void> fetchVendorsAndCharges() async {
    try {
      if (categoryId == null || subCategoryId == null) {
        errorMessage.value = 'Category or Subcategory ID is missing';
        Get.snackbar('Error', errorMessage.value);
        print('Error: $errorMessage');
        return;
      }
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _apiService.fetchVendorsAndCharges(
        categoryId,
        subCategoryId,
      );
      vendorResponse.value = result;
      print('Vendors fetched successfully: ${result.vendors.length} vendors');
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', e.toString());
      print('Error fetching vendors: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh authentication token
  Future<bool> refreshToken() async {
    try {
      // Replace with your actual token refresh logic
      final response = await _dio.post(
        '/api/users/refresh-token', // Adjust endpoint as per your backend
        data: {'user_id': userId.value},
      );
      if (response.statusCode == 200) {
        final newToken = response.data['access_token'];
        await localStorage.setToken(newToken);
        print('Token refreshed successfully');
        return true;
      } else {
        print(
          'Failed to refresh token: ${response.statusCode} - ${response.data}',
        );
        return false;
      }
    } catch (e) {
      print('Error refreshing token: $e');
      return false;
    }
  }

  /// Start Razorpay Payment
  Future<void> startPayment({
    required int vendorId,
    required int categoryId,
    required int subCategoryId,
    required double amount,
  }) async {
    if (userId.value == 0) {
      Get.snackbar('Error', 'User ID not loaded. Please try again.');
      print('Error: User ID not loaded');
      return;
    }

    try {
      var token = await localStorage.getToken();
      if (token == null) {
        Get.snackbar('Error', 'Authentication token not found. Please log in.');
        print('Error: Authentication token not found');
        Get.offAllNamed('/login'); // Redirect to login screen
        return;
      }

      // Step 1: Create booking
      print(
        'Creating booking for userId: ${userId.value}, vendorId: $vendorId, categoryId: $categoryId, subCategoryId: $subCategoryId',
      );
      final bookingResponse = await _dio.post(
        '/api/bookings/',
        data: {
          'user_id': userId.value,
          'serviceprovider_id': vendorId,
          'category_id': categoryId,
          'subcategory_id': subCategoryId,
          'scheduled_time': DateTime.now().toIso8601String(),
          'status': 'pending',
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (bookingResponse.statusCode == 200 ||
          bookingResponse.statusCode == 201) {
        final int bookingId = bookingResponse.data['id'];
        print('Booking created successfully: ID $bookingId');

        // Step 2: Create Razorpay order
        print('Creating Razorpay order for amount: $amount');
        final orderResponse = await _dio.post(
          '/api/payments/create-order',
          data: {'amount': amount.toInt(), 'currency': 'INR'},
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );

        if (orderResponse.statusCode == 200) {
          final data = orderResponse.data;
          print(
            'Razorpay order created: order_id=${data['order_id']}, key=${data['key']}',
          );

          _pendingBooking = {
            'bookingId': bookingId,
            'amount': amount,
            'orderId': data['order_id'],
          };

          var options = {
            'key': data['key'],
            'amount': data['amount'] * 100, // Convert to paise
            'currency': data['currency'],
            'name': 'FixBuddy',
            'description': 'Service Booking',
            'order_id': data['order_id'],
            'prefill': {
              'contact': '', // Optionally add user contact
              'email': '', // Optionally add user email
            },
            'theme': {'color': '#F37254'},
          };

          print('Starting Razorpay payment with options: $options');
          _razorpay.open(options);
        } else {
          print(
            'Failed to create Razorpay order: ${orderResponse.statusCode} - ${orderResponse.data}',
          );
          Get.snackbar(
            'Error',
            'Failed to create payment order: ${orderResponse.statusCode} - ${orderResponse.data}',
          );
          if (orderResponse.statusCode == 401) {
            // Attempt to refresh token
            if (await refreshToken()) {
              print('Retrying payment with refreshed token');
              await startPayment(
                vendorId: vendorId,
                categoryId: categoryId,
                subCategoryId: subCategoryId,
                amount: amount,
              );
            } else {
              Get.snackbar('Error', 'Session expired. Please log in again.');
              Get.offAllNamed('/login'); // Redirect to login screen
            }
          } else if (orderResponse.statusCode == 500 &&
              orderResponse.data.toString().contains(
                'Razorpay authentication failed',
              )) {
            Get.snackbar(
              'Error',
              'Payment service unavailable. Please try again later.',
            );
          }
        }
      } else {
        print(
          'Failed to create booking: ${bookingResponse.statusCode} - ${bookingResponse.data}',
        );
        Get.snackbar(
          'Error',
          'Failed to create booking: ${bookingResponse.statusCode} - ${bookingResponse.data}',
        );
        if (bookingResponse.statusCode == 401) {
          // Attempt to refresh token
          if (await refreshToken()) {
            print('Retrying payment with refreshed token');
            await startPayment(
              vendorId: vendorId,
              categoryId: categoryId,
              subCategoryId: subCategoryId,
              amount: amount,
            );
          } else {
            Get.snackbar('Error', 'Session expired. Please log in again.');
            Get.offAllNamed('/login'); // Redirect to login screen
          }
        }
      }
    } catch (e) {
      print('Error in startPayment: $e');
      Get.snackbar('Error', 'Payment initiation failed: $e');
      if (e is DioException) {
        print(
          'DioException details: ${e.response?.data}, status: ${e.response?.statusCode}',
        );
        if (e.response?.statusCode == 401) {
          // Attempt to refresh token
          if (await refreshToken()) {
            print('Retrying payment with refreshed token');
            await startPayment(
              vendorId: vendorId,
              categoryId: categoryId,
              subCategoryId: subCategoryId,
              amount: amount,
            );
          } else {
            Get.snackbar('Error', 'Session expired. Please log in again.');
            Get.offAllNamed('/login'); // Redirect to login screen
          }
        }
      }
    }
  }

  /// Handle Razorpay success
  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    if (_pendingBooking != null) {
      print(
        'Payment success: paymentId=${response.paymentId}, orderId=${response.orderId}, signature=${response.signature}',
      );
      await _createPayment(
        bookingId: _pendingBooking!['bookingId'],
        amount: _pendingBooking!['amount'],
        paymentId: response.paymentId!,
        orderId: response.orderId!,
        signature: response.signature!,
      );
      _pendingBooking = null;
    } else {
      print('Error: _pendingBooking is null during payment success');
      Get.snackbar('Error', 'Payment succeeded but booking data is missing');
    }
    Get.snackbar('Success', 'Payment successful!');
    // Optionally, navigate to bookings page
    Get.offAllNamed(Routes.booking);
  }

  /// Handle Razorpay error
  void _handlePaymentError(PaymentFailureResponse response) {
    print('Payment error: code=${response.code}, message=${response.message}');
    Get.snackbar('Payment Failed', response.message ?? 'Unknown error');
  }

  /// Save payment details in backend
  Future<void> _createPayment({
    required int bookingId,
    required double amount,
    required String paymentId,
    required String orderId,
    required String signature,
  }) async {
    try {
      final token = await localStorage.getToken();
      if (token == null) {
        Get.snackbar('Error', 'Authentication token not found. Please log in.');
        print('Error: Authentication token not found in _createPayment');
        Get.offAllNamed('/login'); // Redirect to login screen
        return;
      }

      print(
        'Creating payment for bookingId: $bookingId, paymentId: $paymentId, amount: ${(amount * 100).toInt()}',
      );
      final response = await _dio.post(
        '/api/bookings/$bookingId/payment',
        data: {
          'booking_id': bookingId,
          'payment_id': paymentId,
          'order_id': orderId,
          'signature': signature,
          'amount': (amount * 100).toInt(), // Store in paise
          'currency': 'INR',
          'status': 'success',
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Payment stored successfully: ${response.data}');
      } else {
        print(
          '❌ Failed to store payment: ${response.statusCode} - ${response.data}',
        );
        Get.snackbar(
          'Error',
          'Failed to store payment: ${response.statusCode} - ${response.data}',
        );
      }
    } catch (e) {
      print('❌ Error creating payment: $e');
      Get.snackbar('Error', 'Error creating payment: $e');
      if (e is DioException) {
        print(
          'DioException details: ${e.response?.data}, status: ${e.response?.statusCode}',
        );
        if (e.response?.statusCode == 401) {
          Get.snackbar('Error', 'Session expired. Please log in again.');
          Get.offAllNamed('/login'); // Redirect to login screen
        }
      }
    }
  }

  /// Fetch payment details (for debugging)
  Future<bool> fetchPaymentDetails(int bookingId) async {
    try {
      final token = await localStorage.getToken();
      if (token == null) {
        Get.snackbar('Error', 'Authentication token not found. Please log in.');
        print('Error: Authentication token not found in fetchPaymentDetails');
        Get.offAllNamed('/login'); // Redirect to login screen
        return false;
      }

      print('Fetching payment details for bookingId: $bookingId');
      final response = await _dio.get(
        '/api/bookings/$bookingId/payment',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        print('Payment details retrieved: ${response.data}');
        return true;
      } else {
        print(
          'Failed to retrieve payment: ${response.statusCode} - ${response.data}',
        );
        Get.snackbar(
          'Error',
          'Failed to retrieve payment details: ${response.statusCode} - ${response.data}',
        );
        return false;
      }
    } catch (e) {
      print('Error fetching payment details for booking $bookingId: $e');
      Get.snackbar('Error', 'No payment found or error occurred: $e');
      if (e is DioException && e.response?.statusCode == 401) {
        Get.snackbar('Error', 'Session expired. Please log in again.');
        Get.offAllNamed('/login'); // Redirect to login screen
      }
      return false;
    }
  }

  /// Retry payment creation (for debugging)
  Future<void> retryPaymentCreation({
    required int bookingId,
    required double amount,
    required String paymentId,
    required String orderId,
    required String signature,
  }) async {
    print('Retrying payment creation for bookingId: $bookingId');
    await _createPayment(
      bookingId: bookingId,
      amount: amount,
      paymentId: paymentId,
      orderId: orderId,
      signature: signature,
    );
  }

  /// Pull-to-refresh
  Future<void> refreshVendors() async {
    await fetchVendorsAndCharges();
  }

  /// Retry on error
  Future<void> retry() async {
    if (errorMessage.isNotEmpty) {
      await fetchVendorsAndCharges();
    }
  }
}

// import 'package:dio/dio.dart';
// import 'package:fixbuddy/app/constants/api_constants.dart';
// import 'package:fixbuddy/app/modules/allservices/models/service_model.dart';
// import 'package:fixbuddy/app/utils/local_storage.dart';

// class VendorApiService {
//   final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

//   Future<VendorChargeResponse> fetchVendorsAndCharges(
//     int? categoryId,
//     int? subCategoryId,
//   ) async {
//     if (categoryId == null || subCategoryId == null) {
//       throw Exception("Category or Subcategory ID is missing");
//     }

//     final token = await LocalStorage().getToken();

//     final response = await _dio.get(
//       '/api/users/vendors-charges/$categoryId/$subCategoryId',
//       options: Options(
//         headers: token != null ? {"Authorization": "Bearer $token"} : {},
//       ),
//     );

//     if (response.statusCode == 200) {
//       return VendorChargeResponse.fromJson(response.data);
//     } else {
//       throw Exception("Failed to load vendors & charges");
//     }
//   }
// }

// app/modules/allservices/services/service_service.dart
import 'package:dio/dio.dart';
import 'package:fixbuddy/app/constants/api_constants.dart';
import 'package:fixbuddy/app/modules/allservices/models/service_model.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';

class VendorApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl),);

  Future<VendorChargeResponse> fetchVendorsAndCharges(
    int? categoryId,
    int? subCategoryId,
  ) async {
    if (categoryId == null || subCategoryId == null) {
      throw Exception("Category or Subcategory ID is missing");
    }

    final token = await LocalStorage().getToken();

    final response = await _dio.get(
      '/api/users/vendors-charges/$categoryId/$subCategoryId',
      options: Options(
        headers: token != null ? {"Authorization": "Bearer $token"} : {},
      ),
    );

    if (response.statusCode == 200) {
      return VendorChargeResponse.fromJson(response.data);
    } else {
      throw Exception("Failed to load vendors & charges");
    }
  }

  // Future<Map<String, dynamic>> fetchCurrentUser() async {
  //   final token = await LocalStorage().getToken();
  //   if (token == null) {
  //     throw Exception("No authentication token found");
  //   }

  //   final response = await _dio.get(
  //     '/api/users/me', // Assuming this endpoint returns current user details including 'id'
  //     options: Options(headers: {"Authorization": "Bearer $token"}),
  //   );

  //   if (response.statusCode == 200) {
  //     return response.data as Map<String, dynamic>;
  //   } else {
  //     throw Exception("Failed to load current user details");
  //   }
  // }
}

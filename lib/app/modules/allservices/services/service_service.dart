import 'package:dio/dio.dart';
import 'package:fixbuddy/app/constants/api_constants.dart';
import 'package:fixbuddy/app/modules/allservices/models/service_model.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';

class VendorApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

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
}

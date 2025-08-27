import 'package:dio/dio.dart';
import 'package:fixbuddy/app/constants/api_constants.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import '../models/address_model.dart';

class ApiResponse<T> {
  final int statusCode;
  final T data;
  ApiResponse(this.statusCode, this.data);
}

class AddressApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  static const String _tokenPrefix = "Bearer ";

  Future<Options> _getAuthHeaders() async {
    final token = await LocalStorage().getToken();
    return Options(
      headers: token != null
          ? {
              "Authorization": "$_tokenPrefix$token",
              "Content-Type": "application/json",
            }
          : {},
    );
  }

  /// Fetch all addresses for the logged-in user
  Future<ApiResponse<List<AddressModel>>> fetchAddresses() async {
    try {
      final response = await _dio.get(
        "/api/user/",
        options: await _getAuthHeaders(),
      );

      return ApiResponse(
        response.statusCode ?? 200,
        (response.data as List)
            .map((json) => AddressModel.fromJson(json))
            .toList(),
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Add new address
  Future<ApiResponse<AddressModel>> addAddress(AddressModel address) async {
    try {
      final response = await _dio.post(
        "/api/user/address",
        data: address.toJson(),
        options: await _getAuthHeaders(),
      );
      return ApiResponse(
        response.statusCode ?? 201,
        AddressModel.fromJson(response.data),
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Update existing address
  Future<ApiResponse<AddressModel>> updateAddress(AddressModel address) async {
    try {
      final response = await _dio.put(
        "/api/user/address/${address.id}",
        data: address.toJson(),
        options: await _getAuthHeaders(),
      );
      return ApiResponse(
        response.statusCode ?? 200,
        AddressModel.fromJson(response.data),
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Delete address
  Future<ApiResponse<void>> deleteAddress(int id) async {
    try {
      final response = await _dio.delete(
        "/api/user/address/$id",
        options: await _getAuthHeaders(),
      );
      return ApiResponse(response.statusCode ?? 204, null);
    } catch (e) {
      rethrow;
    }
  }

  /// Get single address
  Future<ApiResponse<AddressModel>> getAddress(int id) async {
    try {
      final response = await _dio.get(
        "/api/user/address/$id",
        options: await _getAuthHeaders(),
      );
      return ApiResponse(
        response.statusCode ?? 200,
        AddressModel.fromJson(response.data),
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Set default address
  Future<ApiResponse<AddressModel>> setDefaultAddress(int id) async {
    try {
      final response = await _dio.post(
        "/api/user/address/$id/set-default",
        options: await _getAuthHeaders(),
      );
      return ApiResponse(
        response.statusCode ?? 200,
        AddressModel.fromJson(response.data),
      );
    } catch (e) {
      rethrow;
    }
  }
}

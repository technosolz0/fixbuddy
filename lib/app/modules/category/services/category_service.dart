import 'package:dio/dio.dart';
import 'package:fixbuddy/app/constants/api_constants.dart';
import 'package:fixbuddy/app/modules/category/models/category_model.dart';

class CategoryApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  Future<List<CategoryModel>> fetchCategories() async {
    final response = await _dio.get('/api/categories/');

    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((item) => CategoryModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}

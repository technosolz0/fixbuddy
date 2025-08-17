import 'package:dio/dio.dart';
import 'package:fixbuddy/app/constants/api_constants.dart';
import 'package:fixbuddy/app/modules/subCategory/models/subcategory_model.dart';

class SubcategoryApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  Future<List<SubcategoryModel>> fetchSubcategories() async {
    final response = await _dio.get('/api/subcategories/');

    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((item) => SubcategoryModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load subcategories');
    }
  }
}

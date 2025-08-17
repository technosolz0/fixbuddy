import 'package:fixbuddy/app/modules/allservices/services/service_service.dart';
import 'package:get/get.dart';
import 'package:fixbuddy/app/modules/allservices/models/service_model.dart';

class AllServicesController extends GetxController {
  final VendorApiService _apiService = VendorApiService();

  var isLoading = false.obs;
  var vendorResponse = Rxn<VendorChargeResponse>();
  var errorMessage = ''.obs;

  int? categoryId;
  int? subCategoryId;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;

    if (args != null) {
      categoryId = args['categoryId'] as int?;
      subCategoryId = args['subCategoryId'] as int?;
    }

    fetchVendorsAndCharges();
  }

  Future<void> fetchVendorsAndCharges() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _apiService.fetchVendorsAndCharges(
        categoryId,
        subCategoryId,
      );
      print('resultssss $result');
      vendorResponse.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Pull-to-refresh
  Future<void> refreshVendors() async {
    await fetchVendorsAndCharges();
  }

  /// ✅ Retry on error
  Future<void> retry() async {
    if (errorMessage.isNotEmpty) {
      await fetchVendorsAndCharges();
    }
  }
}

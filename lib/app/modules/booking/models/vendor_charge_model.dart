import 'package:fixbuddy/app/modules/booking/models/vendor_model.dart';

class VendorChargeResponse {
  // Define fields based on your API response
  final List<VendorResponse> vendors;

  VendorChargeResponse({required this.vendors});

  factory VendorChargeResponse.fromJson(Map<String, dynamic> json) {
    return VendorChargeResponse(
      vendors: (json['vendors'] as List)
          .map((v) => VendorResponse.fromJson(v))
          .toList(),
    );
  }
}

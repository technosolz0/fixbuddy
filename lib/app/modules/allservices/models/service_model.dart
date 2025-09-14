class VendorChargeResponse {
  final List<Vendor> vendors;

  VendorChargeResponse({required this.vendors});

  factory VendorChargeResponse.fromJson(Map<String, dynamic> json) {
    return VendorChargeResponse(
      vendors: (json['vendors'] as List<dynamic>? ?? [])
          .map((e) => Vendor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Vendor {
  final int id;
  final double serviceCharge;
  final double rating; // Added rating field
  final VendorDetails? vendorDetails;

  Vendor({
    required this.id,
    required this.serviceCharge,
    required this.rating, // Added rating to constructor
    this.vendorDetails,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'] ?? 0,
      serviceCharge: (json['service_charge'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(), // Parse rating from JSON
      vendorDetails: json['vendor_details'] != null
          ? VendorDetails.fromJson(json['vendor_details'])
          : null,
    );
  }
}

class VendorDetails {
  final int id;
  final String name;
  final String? email;
  final String? contact;
  final String? city;
  final String? state;
  final String? profilePic;

  VendorDetails({
    required this.id,
    required this.name,
    this.email,
    this.contact,
    this.city,
    this.state,
    this.profilePic,
  });

  factory VendorDetails.fromJson(Map<String, dynamic> json) {
    return VendorDetails(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'],
      contact: json['contact'],
      city: json['city'],
      state: json['state'],
      profilePic: json['profile_pic'],
    );
  }
}

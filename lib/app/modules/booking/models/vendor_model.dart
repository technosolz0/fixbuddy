class VendorResponse {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? address;
  final String? state;
  final String? city;
  final String? pincode;

  VendorResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.address,
    this.state,
    this.city,
    this.pincode,
  });

  factory VendorResponse.fromJson(Map<String, dynamic> json) {
    return VendorResponse(
      id: json['id'] ?? 0,
      name: json['full_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      pincode: json['pincode'] ?? '',
    );
  }
}

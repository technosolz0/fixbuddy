class AddressModel {
  final int id;
  final int userId;
  final String name;
  final String phone;
  final String address;
  final String? landmark;
  final String city;
  final String state;
  final String pinCode;
  final String country;
  final String addressType;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.phone,
    required this.address,
    this.landmark,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.country,
    this.addressType = "Home",
    this.isDefault = false,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      landmark: json['landmark'] as String?,
      city: json['city'] as String,
      state: json['state'] as String,
      pinCode: json['pincode'] as String,
      country: json['country'] as String? ?? "India",
      addressType: json['address_type'] as String? ?? "Home",
      isDefault: json['is_default'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'phone': phone,
      'address': address,
      'landmark': landmark,
      'city': city,
      'state': state,
      'pincode': pinCode,
      'country': country,
      'address_type': addressType,
      'is_default': isDefault,
    };
  }
}

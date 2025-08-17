class UserCachedModel {
  final int? id;
  final String? fullName;
  final String? email;
  final String? mobile;
  final String? address;
  final String? image;

  UserCachedModel({
    this.id,
    this.fullName,
    this.email,
    this.mobile,
    this.address,
    this.image,
  });

  static UserCachedModel fromJSON(Map<String, dynamic> json) {
    return UserCachedModel(
      id: json['userId'] is int
          ? json['userId'] as int
          : int.tryParse(json['userId']?.toString() ?? '0'),
      fullName: json['fullName']?.toString(),
      email: json['email']?.toString(),
      mobile: json['mobile']?.toString(),
      address: json['address']?.toString(),
      image: json['image']?.toString(),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'userId': id,
      'fullName': fullName,
      'email': email,
      'mobile': mobile,
      'address': address,
      'image': image,
    };
  }

  static UserCachedModel initialize() {
    return UserCachedModel(
      id: 0,
      fullName: '',
      email: '',
      mobile: '',
      address: '',
      image: '',
    );
  }

  UserCachedModel copyWith({
    int? id,
    String? fullName,
    String? email,
    String? mobile,
    String? address,
    String? image,
  }) {
    return UserCachedModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      address: address ?? this.address,
      image: image ?? this.image,
    );
  }
}

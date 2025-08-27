class CategoryResponse {
  final int id;
  final String name;
  final String status;
  final String? image;

  CategoryResponse({
    required this.id,
    required this.name,
    required this.status,
    this.image,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      image: json['image'],
    );
  }
}

class SubCategoryResponse {
  final int id;
  final String name;
  final String status;
  final String? image;
  final int categoryId;

  SubCategoryResponse({
    required this.id,
    required this.name,
    required this.status,
    this.image,
    required this.categoryId,
  });

  factory SubCategoryResponse.fromJson(Map<String, dynamic> json) {
    return SubCategoryResponse(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      image: json['image'],
      categoryId: json['category_id'],
    );
  }
}

class BookingResponse {
  final int id;
  final int userId;
  final int serviceproviderId;
  final int categoryId;
  final int subcategoryId;
  final DateTime? scheduledTime;
  final String status;
  final DateTime createdAt;
  final String? otp;
  final DateTime? otpCreatedAt;

  // 🔹 New fields
  final CategoryResponse category;
  final SubCategoryResponse subcategory;

  BookingResponse({
    required this.id,
    required this.userId,
    required this.serviceproviderId,
    required this.categoryId,
    required this.subcategoryId,
    this.scheduledTime,
    required this.status,
    required this.createdAt,
    this.otp,
    this.otpCreatedAt,
    required this.category,
    required this.subcategory,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      id: json['id'],
      userId: json['user_id'],
      serviceproviderId: json['serviceprovider_id'],
      categoryId: json['category_id'],
      subcategoryId: json['subcategory_id'],
      scheduledTime: json['scheduled_time'] != null
          ? DateTime.parse(json['scheduled_time'])
          : null,
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      otp: json['otp'],
      otpCreatedAt: json['otp_created_at'] != null
          ? DateTime.parse(json['otp_created_at'])
          : null,
      category: CategoryResponse.fromJson(json['category']),
      subcategory: SubCategoryResponse.fromJson(json['subcategory']),
    );
  }
}

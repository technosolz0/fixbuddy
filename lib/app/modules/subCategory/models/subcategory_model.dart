class SubcategoryModel {
  final int id;
  final String name;
  final String? image;
  final int categoryId;

  final String status;

  SubcategoryModel({
    required this.id,
    required this.name,
    this.image,
    required this.categoryId,
    required this.status,
  });

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      categoryId: json['category_id'],
      status: json['status'],
    );
  }
}

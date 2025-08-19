// // import 'package:fixbuddy/app/modules/category/models/category_model.dart';
// // import 'package:fixbuddy/app/modules/subCategory/models/subcategory_model.dart';

// // class VendorChargeResponse {
// //   final CategoryModel category;
// //   final SubcategoryModel subcategory;
// //   final List<VendorCharge> vendors;

// //   VendorChargeResponse({
// //     required this.category,
// //     required this.subcategory,
// //     required this.vendors,
// //   });

// //   factory VendorChargeResponse.fromJson(Map<String, dynamic> json) {
// //     return VendorChargeResponse(
// //       category: CategoryModel.fromJson(json['category']),
// //       subcategory: SubcategoryModel.fromJson(json['subcategory']),
// //       vendors: (json['vendors'] as List)
// //           .map((v) => VendorCharge.fromJson(v))
// //           .toList(),
// //     );
// //   }
// // }

// // // class Category {
// // //   final int id;
// // //   final String name;

// // //   Category({required this.id, required this.name});

// // //   factory Category.fromJson(Map<String, dynamic> json) {
// // //     return Category(id: json['id'], name: json['name']);
// // //   }
// // // }

// // // class SubCategory {
// // //   final int id;
// // //   final String name;

// // //   SubCategory({required this.id, required this.name});

// // //   factory SubCategory.fromJson(Map<String, dynamic> json) {
// // //     return SubCategory(id: json['id'], name: json['name']);
// // //   }
// // // }

// // class VendorCharge {
// //   final double serviceCharge;
// //   final VendorDetails vendorDetails;

// //   VendorCharge({required this.serviceCharge, required this.vendorDetails});

// //   factory VendorCharge.fromJson(Map<String, dynamic> json) {
// //     return VendorCharge(
// //       serviceCharge: double.tryParse(json['service_charge'].toString()) ?? 0,
// //       vendorDetails: VendorDetails.fromJson(json['vendor_details']),
// //     );
// //   }
// // }

// // class VendorDetails {
// //   final int id;
// //   final String name;
// //   final String email;
// //   final String contact;
// //   final String city;
// //   final String state;
// //   final String profilePic;

// //   VendorDetails({
// //     required this.id,
// //     required this.name,
// //     required this.email,
// //     required this.contact,
// //     required this.city,
// //     required this.state,
// //     required this.profilePic,
// //   });

// //   factory VendorDetails.fromJson(Map<String, dynamic> json) {
// //     return VendorDetails(
// //       id: json['id'],
// //       name: json['name'],
// //       email: json['email'],
// //       contact: json['contact'],
// //       city: json['city'],
// //       state: json['state'],
// //       profilePic: json['profile_pic'],
// //     );
// //   }
// // }

// class VendorChargeResponse {
//   final List<Vendor> vendors;

//   VendorChargeResponse({required this.vendors});

//   factory VendorChargeResponse.fromJson(Map<String, dynamic> json) {
//     return VendorChargeResponse(
//       vendors: (json['vendors'] as List<dynamic>? ?? [])
//           .map((e) => Vendor.fromJson(e as Map<String, dynamic>))
//           .toList(),
//     );
//   }
// }

// class Vendor {
//   final int id;
//   final double serviceCharge;
//   final VendorDetails? vendorDetails;

//   Vendor({required this.id, required this.serviceCharge, this.vendorDetails});

//   factory Vendor.fromJson(Map<String, dynamic> json) {
//     return Vendor(
//       id: json['id'] ?? 0,
//       serviceCharge: (json['service_charge'] ?? 0).toDouble(),
//       vendorDetails: json['vendor_details'] != null
//           ? VendorDetails.fromJson(json['vendor_details'])
//           : null,
//     );
//   }
// }

// class VendorDetails {
//   final int id;
//   final String name;
//   final String? email;
//   final String? contact;
//   final String? city;
//   final String? state;
//   final String? profilePic;

//   VendorDetails({
//     required this.id,
//     required this.name,
//     this.email,
//     this.contact,
//     this.city,
//     this.state,
//     this.profilePic,
//   });

//   factory VendorDetails.fromJson(Map<String, dynamic> json) {
//     return VendorDetails(
//       id: json['id'] ?? 0,
//       name: json['name'] ?? '',
//       email: json['email'],
//       contact: json['contact'],
//       city: json['city'],
//       state: json['state'],
//       profilePic: json['profile_pic'],
//     );
//   }
// }


// app/modules/allservices/models/service_model.dart (assuming this is where models are defined)
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
  final VendorDetails? vendorDetails;

  Vendor({required this.id, required this.serviceCharge, this.vendorDetails});

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'] ?? 0,
      serviceCharge: (json['service_charge'] ?? 0).toDouble(),
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
List<UserModel> usersListFromJSON(List<Map<String, dynamic>> json) {
  List<UserModel> list = [];
  for (int i = 0; i < json.length; i++) {
    list.add(UserModel.fromJSON(json[i]));
  }
  return list;
}

List<Map<String, dynamic>> usersListToJSON(List<UserModel> list) {
  List<Map<String, dynamic>> json = [];
  for (int i = 0; i < list.length; i++) {
    json.add(list[i].toJSON());
  }
  return json = [];
}

class UserModel {
  final String id;
  final String name;
  final String designation;
  final String image;

  UserModel({
    required this.id,
    required this.name,
    required this.designation,
    required this.image,
  });

  static UserModel fromJSON(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      designation: json['designation'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'designation': designation,
      'image': image,
    };
  }

  static UserModel initialize() {
    return UserModel(
      id: '',
      name: '',
      designation: '',
      image: '',
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});
}

class UserModel extends User {
  UserModel({required String id, required String name, required String email})
      : super(id: id, name: name, email: email);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
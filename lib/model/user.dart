class User {
  final String id;
  final String displayName;
  final String email;

  User({required this.id, required this.displayName, required this.email});
}

class UserModel extends User {
  UserModel({required String id, required String displayName, required String email})
      : super(id: id, displayName: displayName, email: email);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      displayName: json['displayName'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': displayName,
      'email': email,
    };
  }
}
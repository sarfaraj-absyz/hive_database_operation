class UserModel {
  int id;
  String username;
  String email;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
  });

  Map<String, dynamic> toMap(UserModel userModel) {
    Map<String, dynamic> userModelMap = Map();
    userModelMap["author"] = userModel.id;
    userModelMap["username"] = userModel.username;
    userModelMap["email"] = userModel.email;
    return userModelMap;
  }

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? 0,
        username: json['username'] ?? '',
        email: json['email'] ?? '',
      );
}

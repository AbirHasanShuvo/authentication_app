// lib/data/user_model.dart
class UserModel {
  final String id;
  final String name;
  final String email;
  final bool emailVerified;
  final String? image;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerified,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        emailVerified: json['emailVerified'],
        image: json['image'],
      );
}

class LoginResponse {
  final String token;
  final UserModel user;

  LoginResponse({required this.token, required this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json['token'],
        user: UserModel.fromJson(json['user']),
      );
}
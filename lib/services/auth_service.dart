import '../core/network/api_client.dart';
import '../data/user_model.dart';

class AuthService {
  final ApiClient apiClient;

  AuthService({required this.apiClient});

  Future<LoginResponse> login(String email, String password) async {
    final response = await apiClient.post('/auth/login', {
      "email": email,
      "password": password,
    });
    return LoginResponse.fromJson(response);
  }


  Future<UserModel> register(String name, String email, String password) async {
    final response = await apiClient.post('/auth/register', {
      "name": name,
      "email": email,
      "password": password,
    });

    return UserModel.fromJson(response);
  }
}

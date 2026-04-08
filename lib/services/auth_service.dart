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
}

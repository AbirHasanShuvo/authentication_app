import 'package:auth_login/utils/storage_service.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../data/user_model.dart';
import '../screens/home_screen.dart';
import '../core/network/api_client.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  Rxn<UserModel> user = Rxn<UserModel>();

  final authService = AuthService(apiClient: ApiClient());
  final storageService = StorageService();

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      final response = await authService.login(email, password);
      user.value = response.user;
      await storageService.saveToken(response.token);
      Get.offAll(() => const HomeScreen());
    } catch (e) {
      Get.snackbar('Login Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await storageService.deleteToken();
    user.value = null;
    Get.offAllNamed('/login');
  }

  Future<void> autoLogin() async {
    final token = await storageService.getToken();
    if (token != null) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAllNamed('/login');
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      isLoading.value = true;
      final userResponse = await authService.register(name, email, password);
      user.value = userResponse;


      Get.snackbar("Success", "Registration completed");
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar("Registration Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

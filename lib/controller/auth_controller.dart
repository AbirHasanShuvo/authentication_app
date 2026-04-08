// lib/controllers/auth_controller.dart
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../data/user_model.dart';
import '../utils/storage_service.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';

class AuthController extends GetxController {
  final AuthService authService;
  final StorageService storageService;

  AuthController({required this.authService, required this.storageService});

  var isLoading = false.obs;
  Rxn<UserModel> user = Rxn<UserModel>();

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      final response = await authService.login(email, password);
      user.value = response.user;
      await storageService.saveToken(response.token);

      // Navigate to Home
      Get.offAll(() => const HomeScreen());
    } catch (e) {
      print('Login error: $e'); // <-- add this
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await storageService.deleteToken();
    user.value = null;
    Get.offAll(() => const LoginScreen());
  }

  Future<void> autoLogin() async {
    final token = await storageService.getToken();
    if (token != null) {
      // Optionally, fetch user info from API using token
      // For now, just go to Home
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }
}

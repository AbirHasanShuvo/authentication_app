// lib/main.dart
import 'package:auth_login/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'services/auth_service.dart';
import 'core/network/api_client.dart';
import 'utils/storage_service.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize AuthController
    Get.put(
      AuthController(
        authService: AuthService(apiClient: ApiClient()),
        storageService: StorageService(),
      ),
    );

    return GetMaterialApp(
      title: 'GetX Login',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(), // <-- Show splash screen first
    );
  }
}
// // lib/main.dart
// import 'package:auth_login/controller/auth_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'services/auth_service.dart';
// import 'core/network/api_client.dart';
// import 'utils/storage_service.dart';
// import 'screens/splash_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Initialize AuthController
//     Get.put(
//       AuthController(
//         authService: AuthService(apiClient: ApiClient()),
//         storageService: StorageService(),
//       ),
//     );

//     return GetMaterialApp(
//       title: 'GetX Login',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const SplashScreen(), // <-- Show splash screen first
//     );
//   }
// }


// lib/main.dart
import 'package:auth_login/controller/auth_controller.dart';
import 'package:auth_login/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize AuthController globally
  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GetX Login App',
      theme: AppTheme.lightTheme,
      // SplashScreen checks if user is already logged in
      home: const SplashScreen(),
      // Optional named routes
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
      ],
    );
  }
}
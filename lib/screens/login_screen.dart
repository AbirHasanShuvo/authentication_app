// // lib/screens/login_screen.dart
// import 'package:auth_login/controller/auth_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../services/auth_service.dart';
// import '../core/network/api_client.dart';
// import '../utils/storage_service.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final AuthController authController = Get.put(
//       AuthController(
//         authService: AuthService(apiClient: ApiClient()),
//         storageService: StorageService(),
//       ),
//     );

//     final emailController = TextEditingController();
//     final passwordController = TextEditingController();
//     final formKey = GlobalKey<FormState>();

//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 controller: emailController,
//                 decoration: const InputDecoration(labelText: 'Email'),
//                 validator: (val) => val!.isEmpty ? 'Enter email' : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: passwordController,
//                 decoration: const InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 validator: (val) => val!.isEmpty ? 'Enter password' : null,
//               ),
//               const SizedBox(height: 24),
//               Obx(
//                 () => ElevatedButton(
//                   onPressed: authController.isLoading.value
//                       ? null
//                       : () {
//                           if (formKey.currentState!.validate()) {
//                             authController.login(
//                               emailController.text.trim(),
//                               passwordController.text.trim(),
//                             );
//                           }
//                         },
//                   child: authController.isLoading.value
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : const Text('Login'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// lib/screens/login_screen.dart
import 'package:auth_login/controller/auth_controller.dart';
import 'package:auth_login/theme/app_text_styles.dart';
import 'package:auth_login/widgets/custom_button.dart';
import 'package:auth_login/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthController authController = Get.put(
    AuthController(), // make sure AuthController is initialized in main.dart or here
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 40),
            _welcomeText('Welcome', 30),
            _welcomeText('Login Here', 20),
            // SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(150),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // EMAIL FIELD
                        CustomTextFormField(
                          prefixIcon: const Icon(Icons.email),
                          hint: "Email",
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }
                            final emailRegex = RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            );
                            if (!emailRegex.hasMatch(value)) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),

                        // PASSWORD FIELD
                        CustomTextFormField(
                          prefixIcon: const Icon(Icons.lock),
                          hint: "Password",
                          controller: passwordController,
                          keyboardType: TextInputType.emailAddress,
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password is required";
                            }
                            if (value.length < 8) {
                              return "Password must be at least 8 characters";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forgot Password?',
                            style: AppTextStyles.caption,
                          ),
                        ),
                        const SizedBox(height: 15),

                        // SIGN IN BUTTON
                        Obx(
                          () => CustomButton(
                            text: authController.isLoading.value
                                ? "Signing In..."
                                : "Sign In",
                            onTap: authController.isLoading.value
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      authController.login(
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                      );
                                    }
                                  },
                            borderRadius: 10,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Text(
                          'Are you not registered?',
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // SIGN UP BUTTON
                        CustomButton(
                          text: "Sign Up",
                          onTap: () {
                            Get.toNamed('/registration');
                          },
                          borderRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _welcomeText(String text, double size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          fontSize: size,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

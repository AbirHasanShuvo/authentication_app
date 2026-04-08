import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/auth_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textformfield.dart';
import '../theme/app_text_styles.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
            _welcomeText('Register Here', 20),
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
                        // NAME FIELD
                        CustomTextFormField(
                          prefixIcon: const Icon(Icons.person),
                          hint: "Name",
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Name is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),

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

                        CustomTextFormField(
                          prefixIcon: const Icon(Icons.lock),
                          hint: "Password",
                          keyboardType: TextInputType.emailAddress,
                          controller: passwordController,
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
                        const SizedBox(height: 20),

                        Obx(
                          () => CustomButton(
                            text: authController.isLoading.value
                                ? "Registering..."
                                : "Register",
                            onTap: authController.isLoading.value
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      authController.register(
                                        nameController.text.trim(),
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                      );
                                    }
                                  },
                            borderRadius: 10,
                          ),
                        ),
                        const SizedBox(height: 15),

                        CustomButton(
                          text: "Back to Login",
                          onTap: () => Get.back(),
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

import 'package:flutter/material.dart';

import '../../data/api/auth_api.dart';
import '../../data/models/dto/Request/UserSignUpRequest.dart';
import '../../routes/app_navigate.dart';
import '../widgets/forms/custom_text_field.dart';
import '../widgets/loadings/loading_page.dart';
import '../widgets/snackbars/custom_snackbar.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final authApi = AuthApi();
  bool isLoading = false;

  Future<void> handleSignUp() async {
    if (usernameController.text.isEmpty ||
        nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      CustomSnackBar.show(context, message: "Vui lòng điền đầy đủ thông tin");
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      CustomSnackBar.show(context, message: "Mật khẩu không khớp");
      return;
    }

    final request = UserSignUpRequest(
      username: usernameController.text,
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    setState(() => isLoading = true);

    try {
      final user = await authApi.signUp(request);
      if (!mounted) return;
      setState(() => isLoading = false);
      CustomSnackBar.show(context, message: "Đăng ký thành công");
      AppNavigator.navigateTo(context, const LoginPage());
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);

      CustomSnackBar.show(context, message: "Tài khoản đã tồn tại");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Nội dung form
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "MeVocab",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextField(
                              controller: usernameController,
                              label: "Tên tài khoản",
                              icon: Icons.person,
                            ),
                            CustomTextField(
                              controller: nameController,
                              label: "Tên của bạn",
                              icon: Icons.badge,
                            ),
                            CustomTextField(
                              controller: emailController,
                              label: "Email",
                              icon: Icons.email,
                            ),
                            CustomTextField(
                              controller: passwordController,
                              label: "Mật khẩu",
                              icon: Icons.lock,
                              obscureText: true,
                            ),
                            CustomTextField(
                              controller: confirmPasswordController,
                              label: "Xác nhận mật khẩu",
                              icon: Icons.lock_outline,
                              obscureText: true,
                            ),
                            ElevatedButton(
                              onPressed: handleSignUp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2575FC),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Đăng ký",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextButton(
                              onPressed: () {
                                AppNavigator.navigateTo(
                                    context, const LoginPage());
                              },
                              child: const Text(
                                "Đã có tài khoản? Đăng nhập",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Layer loading
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: LoadingPage(text: "Đang đăng ký..."),
              ),
            ),
        ],
      ),
    );
  }
}

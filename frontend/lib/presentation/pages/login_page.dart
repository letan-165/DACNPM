import 'package:flutter/material.dart';
import 'package:frontend/data/models/dto/Request/LoginRequest.dart';
import 'package:frontend/presentation/pages/home_page.dart';
import 'package:frontend/presentation/pages/register_page.dart';

import '../../data/api/auth_api.dart';
import '../../data/storage/login_storage.dart';
import '../../routes/app_navigate.dart';
import '../widgets/forms/custom_text_field.dart';
import '../widgets/loadings/loading_page.dart';
import '../widgets/snackbars/custom_snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController(text: "tan1");
  final passwordController = TextEditingController(text: "1");

  final authApi = AuthApi();
  bool isLoading = false;

  Future<void> handleLogin() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      CustomSnackBar.show(context, message: "Vui lòng điền đầy đủ thông tin");
      return;
    }

    final request = LoginRequest(
      username: usernameController.text,
      password: passwordController.text,
    );

    setState(() => isLoading = true);

    try {
      final response = await authApi.login(request);
      LoginStorage.saveLogin(response);

      if (!mounted) return;
      setState(() => isLoading = false);

      CustomSnackBar.show(context, message: "Đăng nhập thành công");
      AppNavigator.navigateTo(context, HomePage());
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
      CustomSnackBar.show(context, message: "Đăng nhập thất bại");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                              controller: passwordController,
                              label: "Mật khẩu",
                              icon: Icons.lock,
                              obscureText: true,
                            ),
                            ElevatedButton(
                              onPressed: handleLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2575FC),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Đăng nhập",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextButton(
                              onPressed: () {
                                AppNavigator.navigateTo(
                                    context, const RegisterPage());
                              },
                              child: const Text(
                                "Chưa có tài khoản? Đăng ký",
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

          // Overlay loading
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: LoadingPage(text: "Đang đăng nhập..."),
              ),
            ),
        ],
      ),
    );
  }
}

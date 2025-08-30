import 'dart:convert';

import 'package:frontend/routes/app_navigate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/pages/login_page.dart';
import '../models/dto/Response/LoginResponse.dart';

class LoginStorage {
  static const _keyLogin = 'login';

  static Future<void> saveLogin(LoginResponse login) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(login.toJson());
    await prefs.setString(_keyLogin, jsonString);
  }

  static Future<LoginResponse> getLogin(context) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyLogin);
    if (jsonString == null) {
      AppNavigator.navigateTo(context, LoginPage());
      throw Exception("User chưa đăng nhập");
    }

    final Map<String, dynamic> json = jsonDecode(jsonString);
    return LoginResponse.fromJson(json);
  }

  static Future<void> clearLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyLogin);
  }
}

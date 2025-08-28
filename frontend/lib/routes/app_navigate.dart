import 'package:flutter/material.dart';

class AppNavigator {
  static Future<T?> navigateTo<T>(BuildContext context, Widget page) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }
}

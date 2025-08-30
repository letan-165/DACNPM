import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/dto/Request/SubmitRequest.dart';

class SubmitStorage {
  static const _keySubmit = 'submit';

  /// Tạo mới storage với resultID và submits rỗng
  static Future<void> create(String resultID) async {
    final prefs = await SharedPreferences.getInstance();
    final data = SubmitRequest(resultID: resultID, submits: []);
    await prefs.setString(_keySubmit, jsonEncode(data.toJson()));
  }

  /// Lưu hoặc cập nhật câu trả lời
  static Future<void> save(int questionID, String answer) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keySubmit);
    if (jsonString == null) {
      throw Exception(
          "SubmitStorage chưa được tạo. Gọi create(resultID) trước.");
    }

    final Map<String, dynamic> json = jsonDecode(jsonString);
    final List submitsJson = json['submits'] ?? [];

    final existingIndex =
        submitsJson.indexWhere((e) => e['questionID'] == questionID);

    if (existingIndex != -1) {
      submitsJson[existingIndex] = Submit(
        questionID: questionID,
        answer: answer,
      ).toJson();
    } else {
      submitsJson.add(Submit(
        questionID: questionID,
        answer: answer,
      ).toJson());
    }

    final updatedData = {
      'resultID': json['resultID'],
      'submits': submitsJson,
    };

    await prefs.setString(_keySubmit, jsonEncode(updatedData));
  }

  /// Lấy 1 submit theo questionID
  static Future<Submit?> get(int questionID) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keySubmit);
    if (jsonString == null) return null;

    final Map<String, dynamic> json = jsonDecode(jsonString);
    final List submitsJson = json['submits'] ?? [];

    final found = submitsJson.firstWhere((e) => e['questionID'] == questionID,
        orElse: () => null);

    if (found == null) return null;
    return Submit.fromJson(Map<String, dynamic>.from(found));
  }

  /// Lấy tất cả submits
  static Future<SubmitRequest?> getRequest() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keySubmit);
    if (jsonString == null) return null;

    final Map<String, dynamic> json = jsonDecode(jsonString);
    final List submitsJson = json['submits'] ?? [];

    return SubmitRequest(
      resultID: json['resultID'],
      submits: submitsJson
          .map((e) => Submit.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }

  /// Xóa storage nếu đúng resultID
  static Future<void> remove(String resultID) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keySubmit);
    if (jsonString == null) return;

    final Map<String, dynamic> json = jsonDecode(jsonString);
    if (json['resultID'] == resultID) {
      await prefs.remove(_keySubmit);
    }
  }
}

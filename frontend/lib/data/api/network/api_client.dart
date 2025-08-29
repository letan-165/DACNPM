import 'package:dio/dio.dart';

import '../../models/Topic.dart';
import '../../models/Word.dart';
import '../../models/dto/Response/ApiResponse.dart';
import '../../models/dto/Response/FlashCardResponse.dart';
import '../../models/dto/Response/QuizResponse.dart';
import '../../models/dto/Response/ResultResponse.dart';
import '../../models/dto/Response/UserResponse.dart';
import 'endpoints.dart';

typedef FromJson<T> = T Function(Map<String, dynamic> json);

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: Host.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(LogInterceptor(responseBody: true));

  static final Map<Type, FromJson<dynamic>> _factories = {
    UserResponse: (json) => UserResponse.fromJson(json),
    Topic: (json) => Topic.fromJson(json),
    Word: (json) => Word.fromJson(json),
    QuizResponse: (json) => QuizResponse.fromJson(json),
    ResultResponse: (json) => ResultResponse.fromJson(json),
    FlashCardResponse: (json) => FlashCardResponse.fromJson(json),
  };

  static Future<T> request<T>(Future<Response> Function(Dio dio) call) async {
    try {
      final res = await call(dio);

      final apiResponse = ApiResponse<T>.fromJson(
        res.data,
        (json) {
          final factory = _factories[T];
          if (factory == null) {
            throw Exception("No fromJson factory registered for type $T");
          }
          return factory(json as Map<String, dynamic>) as T;
        },
      );

      if (apiResponse.code == 1000) {
        if (apiResponse.result == null) {
          throw Exception("Empty result");
        }
        return apiResponse.result as T;
      } else {
        throw apiResponse;
      }
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    }
  }
}

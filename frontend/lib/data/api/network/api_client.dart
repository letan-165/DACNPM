import 'package:dio/dio.dart';

import 'endpoints.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: Host.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(LogInterceptor(responseBody: true));
}

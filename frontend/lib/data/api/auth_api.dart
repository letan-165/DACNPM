import 'package:dio/dio.dart';

import '../models/dto/Request/LoginRequest.dart';
import '../models/dto/Request/UserSignUpRequest.dart';
import '../models/dto/Response/UserResponse.dart';
import 'network/api_client.dart';
import 'network/endpoints.dart';

class AuthApi {
  final Dio _dio = ApiClient.dio;

  Future<UserResponse> signUp(UserSignUpRequest request) {
    return ApiClient.request<UserResponse>(
      (dio) => dio.post(
        "${Endpoints.auth}/signup",
        data: request.toJson(),
      ),
    );
  }

  Future<UserResponse> login(LoginRequest request) {
    return ApiClient.request<UserResponse>(
      (dio) => dio.post(
        "${Endpoints.auth}/login",
        data: request.toJson(),
      ),
    );
  }
}

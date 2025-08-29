import 'package:dio/dio.dart';

import '../models/dto/Response/UserResponse.dart';
import 'network/api_client.dart';
import 'network/endpoints.dart';

class UserApi {
  final Dio _dio = ApiClient.dio;

  Future<List<UserResponse>> findAll() {
    return ApiClient.request<List<UserResponse>>(
      (dio) => dio.get("${Endpoints.user}"),
    );
  }

  Future<UserResponse> findById(String userID) {
    return ApiClient.request<UserResponse>(
      (dio) => dio.get("${Endpoints.user}/id/$userID"),
    );
  }

  Future<UserResponse> findByName(String name) {
    return ApiClient.request<UserResponse>(
      (dio) => dio.get("${Endpoints.user}/name/$name"),
    );
  }
}

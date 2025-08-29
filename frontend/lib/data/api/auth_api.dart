// import 'package:dio/dio.dart';
//
// import 'network/api_client.dart';
// import 'network/endpoints.dart';
//
// class AuthApi {
//   final Dio _dio = ApiClient.dio;
//
//   Future<User> login(String email, String password) async {
//     final res = await _dio.post(
//       Endpoints.login,
//       data: {"email": email, "password": password},
//     );
//     return User.fromJson(res.data);
//   }
//
//   Future<User> register(String email, String password) async {
//     final res = await _dio.post(
//       Endpoints.register,
//       data: {"email": email, "password": password},
//     );
//     return User.fromJson(res.data);
//   }
// }

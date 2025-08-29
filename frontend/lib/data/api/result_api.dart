import 'package:dio/dio.dart';

import '../models/dto/Request/JoinQuizRequest.dart';
import '../models/dto/Request/SubmitRequest.dart';
import '../models/dto/Response/ResultResponse.dart';
import 'network/api_client.dart';
import 'network/endpoints.dart';

class ResultApi {
  final Dio _dio = ApiClient.dio;

  Future<List<ResultResponse>> findAllByStudentID(String studentID) {
    return ApiClient.requestList<ResultResponse>(
      (dio) => dio.get("${Endpoints.result}/$studentID"),
    );
  }

  Future<ResultResponse> join(JoinQuizRequest request) {
    return ApiClient.request<ResultResponse>(
      (dio) => dio.post(
        "${Endpoints.result}/join",
        data: request.toJson(),
      ),
    );
  }

  Future<ResultResponse> submit(SubmitRequest request) {
    return ApiClient.request<ResultResponse>(
      (dio) => dio.post(
        "${Endpoints.result}/submit",
        data: request.toJson(),
      ),
    );
  }

  Future<ResultResponse> finish(String resultID) {
    return ApiClient.request<ResultResponse>(
      (dio) => dio.post("${Endpoints.result}/$resultID/finish"),
    );
  }
}

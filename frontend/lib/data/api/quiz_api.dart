import 'package:dio/dio.dart';

import '../models/dto/Request/QuestionDeleteRequest.dart';
import '../models/dto/Request/QuestionSaveRequest.dart';
import '../models/dto/Request/QuizSaveRequest.dart';
import '../models/dto/Response/QuizResponse.dart';
import 'network/api_client.dart';
import 'network/endpoints.dart';

class QuizApi {
  final Dio _dio = ApiClient.dio;

  Future<List<QuizResponse>> findAll() {
    return ApiClient.request<List<QuizResponse>>(
      (dio) => dio.get("${Endpoints.quiz}"),
    );
  }

  Future<QuizResponse> save(QuizSaveRequest request) {
    return ApiClient.request<QuizResponse>(
      (dio) => dio.post(
        "${Endpoints.quiz}/save",
        data: request.toJson(),
      ),
    );
  }

  Future<bool> delete(String quizID) {
    return ApiClient.request<bool>(
      (dio) => dio.delete("${Endpoints.quiz}/delete/$quizID"),
    );
  }

  Future<List<int>> saveQuestions(QuestionSaveRequest request) {
    return ApiClient.request<List<int>>(
      (dio) => dio.post(
        "${Endpoints.quiz}/questions/save",
        data: request.toJson(),
      ),
    );
  }

  Future<List<int>> deleteQuestions(QuestionDeleteRequest request) {
    return ApiClient.request<List<int>>(
      (dio) => dio.delete(
        "${Endpoints.quiz}/questions/delete",
        data: request.toJson(),
      ),
    );
  }
}

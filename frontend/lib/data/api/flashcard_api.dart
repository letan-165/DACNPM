import 'package:dio/dio.dart';

import '../models/dto/Request/CardSaveRequest.dart';
import '../models/dto/Response/FlashCardResponse.dart';
import 'network/api_client.dart';
import 'network/endpoints.dart';

class FlashCardApi {
  final Dio _dio = ApiClient.dio;

  Future<FlashCardResponse> findByStudentID(String studentID) {
    return ApiClient.request<FlashCardResponse>(
      (dio) => dio.get("${Endpoints.flashcard}/$studentID"),
    );
  }

  Future<FlashCardResponse> findUnmemorizedCards(String studentID) {
    return ApiClient.request<FlashCardResponse>(
      (dio) => dio.get("${Endpoints.flashcard}/unmemorized/$studentID"),
    );
  }

  Future<FlashCardResponse> save(CardSaveRequest request) {
    return ApiClient.request<FlashCardResponse>(
      (dio) => dio.post(
        "${Endpoints.flashcard}/save",
        data: request.toJson(),
      ),
    );
  }
}

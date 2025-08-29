import 'package:dio/dio.dart';

import '../models/Word.dart';
import '../models/dto/Request/WordRequest.dart';
import 'network/api_client.dart';
import 'network/endpoints.dart';

class WordApi {
  final Dio _dio = ApiClient.dio;

  Future<List<Word>> findAll() {
    return ApiClient.requestList<Word>(
      (dio) => dio.get("${Endpoints.word}"),
    );
  }

  Future<List<Word>> findAllByTopic(String topic) {
    return ApiClient.requestList<Word>(
      (dio) => dio.get("${Endpoints.word}/$topic"),
    );
  }

  Future<Word> suggest(WordRequest request) {
    return ApiClient.request<Word>(
      (dio) => dio.post(
        "${Endpoints.word}/suggest",
        data: request.toJson(),
      ),
    );
  }

  Future<Word> create(WordRequest request) {
    return ApiClient.request<Word>(
      (dio) => dio.post(
        "${Endpoints.word}/create",
        data: request.toJson(),
      ),
    );
  }

  Future<bool> deleteById(String word) {
    return ApiClient.request<bool>(
      (dio) => dio.delete("${Endpoints.word}/$word"),
    );
  }
}

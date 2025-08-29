import 'package:dio/dio.dart';

import '../models/Topic.dart';
import 'network/api_client.dart';
import 'network/endpoints.dart';

class TopicApi {
  final Dio _dio = ApiClient.dio;

  Future<List<Topic>> findAll() {
    return ApiClient.request<List<Topic>>(
      (dio) => dio.get("${Endpoints.topic}"),
    );
  }

  Future<Topic> save(Topic topic) {
    return ApiClient.request<Topic>(
      (dio) => dio.post(
        "${Endpoints.topic}/save",
        data: topic.toJson(),
      ),
    );
  }

  Future<bool> deleteById(String name) {
    return ApiClient.request<bool>(
      (dio) => dio.delete("${Endpoints.topic}/$name"),
    );
  }
}

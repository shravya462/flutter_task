import 'package:dio/dio.dart';

class BaseClient {
  // Singleton pattern
  static final BaseClient _instance = BaseClient._internal();
  factory BaseClient() => _instance;

  BaseClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: 'http://192.168.0.109:5000/',
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
      headers: {
        'Content-Type': 'application/json',
      },
    ));
  }

  late final Dio _dio;

  // Public method to get the Dio instance
  Dio get dio => _dio;

  // Example API call: GET request
  Future<Response> getData(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response;
    } on DioError catch (e) {
      // Handle error
      throw Exception('Failed to load data: ${e.message}');
    }
  }

  // Example API call: POST request
  Future<Response> postData(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioError catch (e) {
      // Handle error
      throw Exception('Failed to post data: ${e.message}');
    }
  }

  // Example API call: PUT request
  Future<Response> putData(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } on DioError catch (e) {
      // Handle error
      throw Exception('Failed to update data: ${e.message}');
    }
  }

  // Example API call: DELETE request
  Future<Response> deleteData(String endpoint,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      return response;
    } on DioError catch (e) {
      // Handle error
      throw Exception('Failed to delete data: ${e.message}');
    }
  }
}

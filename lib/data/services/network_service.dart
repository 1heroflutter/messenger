import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/utils/config/env_config.dart';
class NetworkService {
  static final String baseUrl = EnvConfig.baseUrl;
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<Map<String, dynamic>> _getHeaders(bool requiresAuth) async {
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
    };

    if (requiresAuth) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String? idToken = await user.getIdToken();
        headers['Authorization'] = 'Bearer $idToken';
      }
    }
    return headers;
  }

  Future<Response?> get(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
        bool requiresAuth = true,
      }) async {
    try {
      final headers = await _getHeaders(requiresAuth);

      return await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      print("Lỗi API GET: ${e.response?.data ?? e.message}");
      return e.response;
    }
  }

  Future<Response?> post(
      String endpoint, {
        dynamic? data,
        bool requiresAuth = true,
      }) async {
    try {
      final headers = await _getHeaders(requiresAuth);

      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(
          headers: headers,
          responseType: ResponseType.json,
        ),
      );
      return response;
    } on DioException catch (e) {
      print("Lỗi API POST: ${e.response?.data ?? e.message}");
      return e.response;
    }
  }
  Future<Response?> patch(
      String endpoint, {
        dynamic data,
        bool requiresAuth = true,
      }) async {
    try {
      final headers = await _getHeaders(requiresAuth);

      return await _dio.patch(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      // Log lỗi chi tiết để debug dễ hơn
      print("Lỗi API PATCH: ${e.response?.data ?? e.message}");
      return e.response;
    }
  }
  Future<Response?> delete(
      String endpoint, {
        dynamic data,
        bool requiresAuth = true,
      }) async {
    try {
      final headers = await _getHeaders(requiresAuth);

      return await _dio.delete(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      // Log lỗi chi tiết để debug dễ hơn
      print("Lỗi API PATCH: ${e.response?.data ?? e.message}");
      return e.response;
    }
  }
}
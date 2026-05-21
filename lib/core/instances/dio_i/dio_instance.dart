import 'package:dio/dio.dart';

class DioInstance {
  const DioInstance._();

  static const _httpTimeout = Duration(seconds: 30);

  static final dio = Dio(
    BaseOptions(
      baseUrl: 'https://pokeapi.co/api/v2/',
      connectTimeout: _httpTimeout,
      receiveTimeout: _httpTimeout,
      sendTimeout: _httpTimeout,
    ),
  );
}

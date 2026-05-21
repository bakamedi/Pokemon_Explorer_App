import 'package:dio/dio.dart';
import 'package:poke_test/domain/models/eighter/either.dart';

import '../../../domain/models/failures/failure.dart';
import 'http_method.dart';

class HttpHelper {
  final Dio _dio;

  HttpHelper({required this._dio});

  Future<Either<Failure, T>> request<T>(
    String pathOrUrl, {
    HttpMethod method = HttpMethod.GET,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic> headers = const {},
    String? bearerToken,
    dynamic data,
    T Function(dynamic responseData)? parser,
    int retry = 1,
    int attempts = 0,
  }) async {
    try {
      final finalHeaders = {
        ...headers,
        if (bearerToken != null) 'Authorization': 'Bearer $bearerToken',
      };

      final response = await _dio.request(
        pathOrUrl,
        options: Options(method: method.name, headers: finalHeaders),
        queryParameters: queryParameters,
        data: data,
      );

      final parsedData = parser != null
          ? parser(response.data)
          : response.data as T;

      return Either.right(parsedData);
    } on DioException catch (e) {
      if (_isTimeout(e)) {
        return Either.left(const Failure.timeout());
      }

      if (e.type == DioExceptionType.badResponse && e.response != null) {
        if (attempts + 1 < retry) {
          return request<T>(
            pathOrUrl,
            method: method,
            queryParameters: queryParameters,
            headers: headers,
            bearerToken: bearerToken,
            data: data,
            parser: parser,
            retry: retry,
            attempts: attempts + 1,
          );
        }

        return Either.left(
          Failure.api(
            statusCode: e.response!.statusCode,
            message: 'Error del servidor',
          ),
        );
      }

      return const Either.left(Failure.network());
    } catch (e) {

      return const Either.left(Failure.unknown());
    }
  }

  bool _isTimeout(DioException e) =>
      e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.sendTimeout;
}

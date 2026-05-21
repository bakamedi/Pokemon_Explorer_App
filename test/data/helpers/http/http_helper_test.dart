import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_test/data/helpers/http/http_helper.dart';
import 'package:poke_test/domain/models/failures/failure.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late HttpHelper httpHelper;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    httpHelper = HttpHelper(dio: mockDio);
  });

  group('HttpHelper - Network Errors', () {
    test('Should return Failure.network when a SocketException (Host Lookup Failed) occurs', () async {
      // Arrange
      when(() => mockDio.request(
            any(),
            options: any(named: 'options'),
            queryParameters: any(named: 'queryParameters'),
            data: any(named: 'data'),
          )).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: 'test'),
          type: DioExceptionType.unknown,
          error: 'Failed host lookup: \'pokeapi.co\'',
          message: 'The connection errored: Failed host lookup: \'pokeapi.co\'',
        ),
      );

      // Act
      final result = await httpHelper.request('test');

      // Assert
      expect(result.isLeft, true);
      result.fold(
        (failure) {
          expect(failure, isA<NetworkFailure>());
          expect(failure.message.contains('Failed host lookup'), true);
        },
        (_) => fail('Should have failed'),
      );
    });

    test('Should return Failure.timeout when a connection timeout occurs', () async {
      // Arrange
      when(() => mockDio.request(
            any(),
            options: any(named: 'options'),
            queryParameters: any(named: 'queryParameters'),
            data: any(named: 'data'),
          )).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: 'test'),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      // Act
      final result = await httpHelper.request('test');

      // Assert
      expect(result.isLeft, true);
      result.fold(
        (failure) => expect(failure, isA<TimeoutFailure>()),
        (_) => fail('Should have failed'),
      );
    });
  });

  group('HttpHelper - Success', () {
    test('Should return right(data) when request is successful', () async {
      // Arrange
      final responseData = {'name': 'bulbasaur'};
      when(() => mockDio.request(
            any(),
            options: any(named: 'options'),
            queryParameters: any(named: 'queryParameters'),
            data: any(named: 'data'),
          )).thenAnswer(
        (_) async => Response(
          data: responseData,
          requestOptions: RequestOptions(path: 'test'),
          statusCode: 200,
        ),
      );

      // Act
      final result = await httpHelper.request<Map<String, dynamic>>('test');

      // Assert
      expect(result.isRight, true);
      expect(result.getRightOrNull(), responseData);
    });
  });
}

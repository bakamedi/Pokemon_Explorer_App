import 'package:flutter_test/flutter_test.dart';
import 'package:poke_test/core/instances/dio_i/dio_instance.dart';

void main() {
  group('DioInstance', () {
    test('is properly initialized with correct configuration', () {
      final dio = DioInstance.dio;
      expect(dio, isNotNull);
      expect(dio.options.baseUrl, 'https://pokeapi.co/api/v2/');
      expect(dio.options.connectTimeout, const Duration(seconds: 30));
      expect(dio.options.receiveTimeout, const Duration(seconds: 30));
      expect(dio.options.sendTimeout, const Duration(seconds: 30));
    });
  });
}

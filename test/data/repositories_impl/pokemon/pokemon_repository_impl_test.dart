import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_test/data/providers/pokemon/pokemon_provider.dart';
import 'package:poke_test/data/repositories_impl/pokemon/pokemon_repository_impl.dart';
import 'package:poke_test/domain/models/eighter/either.dart';
import 'package:poke_test/domain/models/pokemon_detail_model.dart';
import 'package:poke_test/domain/repositories/device/device_repository.dart';
import 'package:poke_test/domain/responses/pokemon_response_model.dart';

class MockPokemonProvider extends Mock implements PokemonProvider {}
class MockDeviceRepository extends Mock implements DeviceRepository {}

void main() {
  late PokemonRepositoryImpl repository;
  late MockPokemonProvider mockPokemonProvider;
  late MockDeviceRepository mockDeviceRepository;

  setUp(() {
    mockPokemonProvider = MockPokemonProvider();
    mockDeviceRepository = MockDeviceRepository();
    repository = PokemonRepositoryImpl(
      pokemonProvider: mockPokemonProvider,
      deviceRepository: mockDeviceRepository,
    );
  });

  group('PokemonRepositoryImpl - fetchAllPokemon', () {
    test('Should forward fetchAllPokemon to provider', () async {
      // Arrange
      final mockResponse = PokemonResponseModel(
        count: 0,
        results: [],
        next: null,
        previous: null,
      );
      when(() => mockPokemonProvider.fetchAllPokemon(
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          )).thenAnswer((_) async => Either.right(mockResponse));

      // Act
      final result = await repository.fetchAllPokemon(limit: 10, offset: 5);

      // Assert
      expect(result.isRight, true);
      expect(result.getRightOrNull(), mockResponse);
      verify(() => mockPokemonProvider.fetchAllPokemon(limit: 10, offset: 5))
          .called(1);
    });
  });

  group('PokemonRepositoryImpl - fetchPokemonDetail', () {
    test('Should forward fetchPokemonDetail to provider', () async {
      // Arrange
      const mockDetail = PokemonDetailModel(
        id: 1,
        name: 'bulbasaur',
        height: 7,
        weight: 69,
        types: [],
        abilities: [],
        stats: [],
      );
      when(() => mockPokemonProvider.fetchPokemonDetail('bulbasaur'))
          .thenAnswer((_) async => Either.right(mockDetail));

      // Act
      final result = await repository.fetchPokemonDetail('bulbasaur');

      // Assert
      expect(result.isRight, true);
      expect(result.getRightOrNull(), mockDetail);
      verify(() => mockPokemonProvider.fetchPokemonDetail('bulbasaur'))
          .called(1);
    });
  });

  group('PokemonRepositoryImpl - getFavorites', () {
    test('Should return empty list when storage is empty or null', () async {
      // Arrange
      when(() => mockDeviceRepository.readString(key: 'favorites_pokemon'))
          .thenAnswer((_) async => null);

      // Act
      final result = await repository.getFavorites();

      // Assert
      expect(result, isEmpty);
      verify(() => mockDeviceRepository.readString(key: 'favorites_pokemon'))
          .called(1);
    });

    test('Should return list of PokemonModel when storage has valid JSON',
        () async {
      // Arrange
      final p1 = PokemonModel(name: 'pikachu', url: 'url1');
      final p2 = PokemonModel(name: 'ditto', url: 'url2');
      final jsonStr = jsonEncode([p1.toJson(), p2.toJson()]);

      when(() => mockDeviceRepository.readString(key: 'favorites_pokemon'))
          .thenAnswer((_) async => jsonStr);

      // Act
      final result = await repository.getFavorites();

      // Assert
      expect(result.length, 2);
      expect(result[0].name, 'pikachu');
      expect(result[1].name, 'ditto');
    });

    test('Should return empty list when stored JSON is invalid', () async {
      // Arrange
      when(() => mockDeviceRepository.readString(key: 'favorites_pokemon'))
          .thenAnswer((_) async => '{invalid json}');

      // Act
      final result = await repository.getFavorites();

      // Assert
      expect(result, isEmpty);
    });
  });

  group('PokemonRepositoryImpl - addFavorite', () {
    test('Should write updated favorites to storage if not already favorited',
        () async {
      // Arrange
      final pokemon = PokemonModel(name: 'eevee', url: 'url');
      when(() => mockDeviceRepository.readString(key: 'favorites_pokemon'))
          .thenAnswer((_) async => '[]');
      when(() => mockDeviceRepository.writeString(
            key: 'favorites_pokemon',
            value: any(named: 'value'),
          )).thenAnswer((_) async => {});

      // Act
      await repository.addFavorite(pokemon);

      // Assert
      final expectedJson = jsonEncode([pokemon.toJson()]);
      verify(() => mockDeviceRepository.writeString(
            key: 'favorites_pokemon',
            value: expectedJson,
          )).called(1);
    });

    test('Should not write duplicate to storage if already favorited',
        () async {
      // Arrange
      final pokemon = PokemonModel(name: 'eevee', url: 'url');
      final existingJson = jsonEncode([pokemon.toJson()]);
      when(() => mockDeviceRepository.readString(key: 'favorites_pokemon'))
          .thenAnswer((_) async => existingJson);

      // Act
      await repository.addFavorite(pokemon);

      // Assert
      verifyNever(() => mockDeviceRepository.writeString(
            key: 'favorites_pokemon',
            value: any(named: 'value'),
          ));
    });
  });

  group('PokemonRepositoryImpl - removeFavorite', () {
    test('Should write filtered favorites to storage', () async {
      // Arrange
      final p1 = PokemonModel(name: 'eevee', url: 'url1');
      final p2 = PokemonModel(name: 'mew', url: 'url2');
      final existingJson = jsonEncode([p1.toJson(), p2.toJson()]);

      when(() => mockDeviceRepository.readString(key: 'favorites_pokemon'))
          .thenAnswer((_) async => existingJson);
      when(() => mockDeviceRepository.writeString(
            key: 'favorites_pokemon',
            value: any(named: 'value'),
          )).thenAnswer((_) async => {});

      // Act
      await repository.removeFavorite(p1);

      // Assert
      final expectedJson = jsonEncode([p2.toJson()]);
      verify(() => mockDeviceRepository.writeString(
            key: 'favorites_pokemon',
            value: expectedJson,
          )).called(1);
    });
  });
}

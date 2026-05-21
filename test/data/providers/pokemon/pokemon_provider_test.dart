import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_test/data/helpers/http/http_helper.dart';
import 'package:poke_test/data/providers/pokemon/pokemon_provider.dart';
import 'package:poke_test/domain/models/eighter/either.dart';
import 'package:poke_test/domain/models/failures/failure.dart';
import 'package:poke_test/domain/responses/pokemon_response_model.dart';
import 'package:poke_test/domain/models/pokemon_detail_model.dart';

class MockHttpHelper extends Mock implements HttpHelper {}

void main() {
  late PokemonProvider pokemonProvider;
  late MockHttpHelper mockHttpHelper;

  setUp(() {
    mockHttpHelper = MockHttpHelper();
    pokemonProvider = PokemonProvider(
      httpHelper: mockHttpHelper,
      basePath: 'pokemon',
    );
  });

  group('PokemonProvider - fetchAllPokemon', () {
    test('Should return right(PokemonResponseModel) on success', () async {
      // Arrange
      final mockJson = {
        'count': 1,
        'next': null,
        'previous': null,
        'results': [
          {'name': 'bulbasaur', 'url': 'url'}
        ]
      };
      
      when(() => mockHttpHelper.request<PokemonResponseModel>(
            any(),
            headers: any(named: 'headers'),
            parser: any(named: 'parser'),
          )).thenAnswer((_) async => Either.right(PokemonResponseModel.fromJson(mockJson)));

      // Act
      final result = await pokemonProvider.fetchAllPokemon();

      // Assert
      expect(result.isRight, true);
      expect(result.getRightOrNull()?.results.first.name, 'bulbasaur');
    });

    test('Should return left(Failure) on error', () async {
      // Arrange
      when(() => mockHttpHelper.request<PokemonResponseModel>(
            any(),
            headers: any(named: 'headers'),
            parser: any(named: 'parser'),
          )).thenAnswer((_) async => Either.left(const Failure.network()));

      // Act
      final result = await pokemonProvider.fetchAllPokemon();

      // Assert
      expect(result.isLeft, true);
      expect(result.getLeftOrNull(), isA<NetworkFailure>());
    });
  });

  group('PokemonProvider - fetchPokemonDetail', () {
    test('Should return right(PokemonDetailModel) on success', () async {
      // Arrange
      final mockJson = {
        'id': 1,
        'name': 'bulbasaur',
        'height': 7,
        'weight': 69,
        'sprites': {
          'other': {
            'official-artwork': {'front_default': 'url'}
          }
        },
        'types': [],
        'abilities': [],
        'stats': [],
      };

      when(() => mockHttpHelper.request<PokemonDetailModel>(
            any(),
            headers: any(named: 'headers'),
            parser: any(named: 'parser'),
          )).thenAnswer((_) async => Either.right(PokemonDetailModel.fromJson(mockJson)));

      // Act
      final result = await pokemonProvider.fetchPokemonDetail('1');

      // Assert
      expect(result.isRight, true);
      expect(result.getRightOrNull()?.name, 'bulbasaur');
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_test/domain/models/eighter/either.dart';
import 'package:poke_test/domain/models/failures/failure.dart';
import 'package:poke_test/domain/models/pokemon_detail_model.dart';
import 'package:poke_test/domain/repositories/pokemon/pokemon_repository.dart';
import 'package:poke_test/presentation/globals/utils/app_view_state_util.dart';
import 'package:poke_test/presentation/modules/pokemon_detail/controller/pokemon_detail_controller.dart';
import 'package:poke_test/presentation/modules/pokemon_detail/controller/pokemon_state.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late PokemonDetailController pokemonDetailController;
  late MockPokemonRepository mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    pokemonDetailController = PokemonDetailController(
      PokemonState.initialState,
      pokemonRepository: mockPokemonRepository,
    );
  });

  group('PokemonDetailController - Initialization', () {
    test('Should initialize with correct initial state', () {
      expect(pokemonDetailController.state.pokemonId, isNull);
      expect(pokemonDetailController.state.pokemon, isNull);
      expect(pokemonDetailController.state.appViewStateUtil, AppViewStateUtil.idle);
    });
  });

  group('PokemonDetailController - onChangeId', () {
    test('Should update pokemonId in state', () {
      pokemonDetailController.onChangeId(25);
      expect(pokemonDetailController.state.pokemonId, 25);
    });
  });

  group('PokemonDetailController - loadPokemon', () {
    test('Should fetch pokemon detail and update state to success on success', () async {
      // Arrange
      const expectedPokemon = PokemonDetailModel(
        id: 25,
        name: 'pikachu',
        height: 4,
        weight: 60,
        types: [],
        abilities: [],
        stats: [],
      );

      pokemonDetailController.onChangeId(25);

      when(() => mockPokemonRepository.fetchPokemonDetail('25'))
          .thenAnswer((_) async => Either.right(expectedPokemon));

      // Act
      pokemonDetailController.loadPokemon();

      // Assert loading state (synchronous first part)
      expect(pokemonDetailController.state.appViewStateUtil, AppViewStateUtil.loading);

      // Wait for async execution to complete
      await Future.delayed(const Duration(milliseconds: 10));

      // Assert final state
      expect(pokemonDetailController.state.appViewStateUtil, AppViewStateUtil.success);
      expect(pokemonDetailController.state.pokemon, expectedPokemon);
      expect(pokemonDetailController.state.pokemonId, 25);
      verify(() => mockPokemonRepository.fetchPokemonDetail('25')).called(1);
    });

    test('Should update state to error when repository call fails', () async {
      // Arrange
      pokemonDetailController.onChangeId(25);

      when(() => mockPokemonRepository.fetchPokemonDetail('25'))
          .thenAnswer((_) async => Either.left(const Failure.network()));

      // Act
      pokemonDetailController.loadPokemon();

      // Assert loading state
      expect(pokemonDetailController.state.appViewStateUtil, AppViewStateUtil.loading);

      // Wait for async execution to complete
      await Future.delayed(const Duration(milliseconds: 10));

      // Assert final state
      expect(pokemonDetailController.state.appViewStateUtil, AppViewStateUtil.error);
      expect(pokemonDetailController.state.pokemon, isNull);
      verify(() => mockPokemonRepository.fetchPokemonDetail('25')).called(1);
    });
  });
}

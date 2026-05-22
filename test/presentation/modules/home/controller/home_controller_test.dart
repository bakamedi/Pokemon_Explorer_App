import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_test/domain/models/eighter/either.dart';
import 'package:poke_test/domain/models/failures/failure.dart';
import 'package:poke_test/domain/models/pokemon_detail_model.dart';
import 'package:poke_test/domain/repositories/index_repositories.dart';
import 'package:poke_test/domain/responses/pokemon_response_model.dart';
import 'package:poke_test/presentation/modules/home/controller/home_controller.dart';
import 'package:poke_test/presentation/modules/home/controller/home_state.dart';
import 'package:poke_test/presentation/globals/utils/app_view_state_util.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}
class MockDeviceRepository extends Mock implements DeviceRepository {}

void main() {
  late HomeController homeController;
  late MockPokemonRepository mockPokemonRepository;
  late MockDeviceRepository mockDeviceRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    mockDeviceRepository = MockDeviceRepository();
    
    // Stub initial load call in constructor
    when(() => mockPokemonRepository.fetchAllPokemon(
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        )).thenAnswer((_) async => Either.right(PokemonResponseModel(
          count: 0,
          results: [],
          next: null,
          previous: null,
        )));
    when(() => mockPokemonRepository.getFavorites())
        .thenAnswer((_) async => []);

    homeController = HomeController(
      HomeState.initialState,
      pokemonRepository: mockPokemonRepository,
      deviceRepository: mockDeviceRepository,
    );
  });

  group('HomeController - loadPokemons', () {
    test('Should update state to success when fetchAllPokemon succeeds', () async {
      // Arrange
      final mockResponse = PokemonResponseModel(
        count: 1,
        results: [PokemonModel(name: 'bulbasaur', url: 'url')],
        next: null,
        previous: null,
      );

      when(() => mockPokemonRepository.fetchAllPokemon(
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          )).thenAnswer((_) async => Either.right(mockResponse));

      // Act
      await homeController.loadPokemons();

      // Assert
      expect(homeController.state.appViewStateUtil, AppViewStateUtil.success);
      expect(homeController.state.pokemonResponse?.results.length, 1);
      expect(homeController.state.pokemonResponse?.results.first.name, 'bulbasaur');
    });

    test('Should update state to error when fetchAllPokemon fails', () async {
      // Arrange
      when(() => mockPokemonRepository.fetchAllPokemon(
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          )).thenAnswer((_) async => Either.left(const Failure.network()));

      // Act
      await homeController.loadPokemons();

      // Assert
      expect(homeController.state.appViewStateUtil, AppViewStateUtil.error);
    });
  });

  group('HomeController - loadMorePokemons', () {
    test('Should do nothing if pokemonResponse is null', () async {
      // Arrange
      homeController.state = homeController.state.copyWith(pokemonResponse: null);
      clearInteractions(mockPokemonRepository);

      // Act
      await homeController.loadMorePokemons();

      // Assert
      expect(homeController.state.isLoadMore, false);
      verifyNever(() => mockPokemonRepository.fetchAllPokemon(
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ));
    });

    test('Should do nothing if pokemonResponse.next is null', () async {
      // Arrange
      final initialResponse = PokemonResponseModel(
        count: 1,
        results: [PokemonModel(name: 'bulbasaur', url: 'url')],
        next: null,
        previous: null,
      );
      homeController.state = homeController.state.copyWith(
        pokemonResponse: initialResponse,
        isLoadMore: false,
      );
      clearInteractions(mockPokemonRepository);

      // Act
      await homeController.loadMorePokemons();

      // Assert
      expect(homeController.state.isLoadMore, false);
      verifyNever(() => mockPokemonRepository.fetchAllPokemon(
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ));
    });

    test('Should do nothing if isLoadMore is already true', () async {
      // Arrange
      final initialResponse = PokemonResponseModel(
        count: 2,
        results: [PokemonModel(name: 'bulbasaur', url: 'url')],
        next: 'has_more_url',
        previous: null,
      );
      homeController.state = homeController.state.copyWith(
        pokemonResponse: initialResponse,
        isLoadMore: true,
      );
      clearInteractions(mockPokemonRepository);

      // Act
      await homeController.loadMorePokemons();

      // Assert
      expect(homeController.state.isLoadMore, true);
      verifyNever(() => mockPokemonRepository.fetchAllPokemon(
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ));
    });

    test('Should fetch and append new results when fetchAllPokemon succeeds', () async {
      // Arrange
      final initialResponse = PokemonResponseModel(
        count: 3,
        results: [PokemonModel(name: 'bulbasaur', url: 'url')],
        next: 'has_more_url',
        previous: null,
      );
      final newResponse = PokemonResponseModel(
        count: 3,
        results: [PokemonModel(name: 'charmander', url: 'url')],
        next: null,
        previous: 'has_more_url',
      );

      homeController.state = homeController.state.copyWith(
        pokemonResponse: initialResponse,
        isLoadMore: false,
      );

      when(() => mockPokemonRepository.fetchAllPokemon(
            limit: any(named: 'limit'),
            offset: 1,
          )).thenAnswer((_) async => Either.right(newResponse));

      clearInteractions(mockPokemonRepository);

      // Act
      await homeController.loadMorePokemons();

      // Assert
      expect(homeController.state.isLoadMore, false);
      expect(homeController.state.pokemonResponse?.results.length, 2);
      expect(homeController.state.pokemonResponse?.results[0].name, 'bulbasaur');
      expect(homeController.state.pokemonResponse?.results[1].name, 'charmander');
      expect(homeController.state.pokemonResponse?.next, isNull);
      verify(() => mockPokemonRepository.fetchAllPokemon(limit: any(named: 'limit'), offset: 1)).called(1);
    });

    test('Should set isLoadMore to false when fetchAllPokemon fails', () async {
      // Arrange
      final initialResponse = PokemonResponseModel(
        count: 3,
        results: [PokemonModel(name: 'bulbasaur', url: 'url')],
        next: 'has_more_url',
        previous: null,
      );

      homeController.state = homeController.state.copyWith(
        pokemonResponse: initialResponse,
        isLoadMore: false,
      );

      when(() => mockPokemonRepository.fetchAllPokemon(
            limit: any(named: 'limit'),
            offset: 1,
          )).thenAnswer((_) async => Either.left(const Failure.network()));

      clearInteractions(mockPokemonRepository);

      // Act
      await homeController.loadMorePokemons();

      // Assert
      expect(homeController.state.isLoadMore, false);
      expect(homeController.state.pokemonResponse?.results.length, 1);
      verify(() => mockPokemonRepository.fetchAllPokemon(limit: any(named: 'limit'), offset: 1)).called(1);
    });
  });

  group('HomeController - Search', () {
    test('Should filter results locally when search query changes', () async {
      // Arrange
      final mockResponse = PokemonResponseModel(
        count: 2,
        results: [
          PokemonModel(name: 'bulbasaur', url: 'url'),
          PokemonModel(name: 'charmander', url: 'url'),
        ],
        next: null,
        previous: null,
      );
      
      homeController.state = homeController.state.copyWith(pokemonResponse: mockResponse);

      // Act
      homeController.onSearchChanged('bulb');

      // Assert
      expect(homeController.state.searchResult?.length, 1);
      expect(homeController.state.searchResult?.first.name, 'bulbasaur');
    });

    test('Should clear searchResult if query is empty', () {
      // Arrange
      homeController.state = homeController.state.copyWith(
        searchResult: [PokemonModel(name: 'bulbasaur', url: 'url')],
      );

      // Act
      homeController.onSearchChanged('  ');

      // Assert
      expect(homeController.state.searchResult, isNull);
      expect(homeController.state.search, '  ');
    });

    test('Should do nothing on empty search query in API search', () async {
      // Arrange
      homeController.state = homeController.state.copyWith(search: '');

      // Act
      await homeController.searchPokemonFromAPI();

      // Assert
      expect(homeController.state.searchLoading, false);
      verifyNever(() => mockPokemonRepository.fetchPokemonDetail(any()));
    });

    test('Should fetch from API and update searchResult on success', () async {
      // Arrange
      homeController.state = homeController.state.copyWith(search: 'pikachu');
      
      const mockDetail = PokemonDetailModel(
        id: 25,
        name: 'pikachu',
        height: 4,
        weight: 60,
        types: [],
        abilities: [],
        stats: [],
      );

      when(() => mockPokemonRepository.fetchPokemonDetail('pikachu'))
          .thenAnswer((_) async => Either.right(mockDetail));

      // Act
      await homeController.searchPokemonFromAPI();

      // Assert
      expect(homeController.state.searchLoading, false);
      expect(homeController.state.searchResult?.length, 1);
      expect(homeController.state.searchResult?.first.name, 'pikachu');
      expect(homeController.state.searchResult?.first.url, 'https://pokeapi.co/api/v2/pokemon/25/');
      verify(() => mockPokemonRepository.fetchPokemonDetail('pikachu')).called(1);
    });

    test('Should set searchResult to empty list when API search fails', () async {
      // Arrange
      homeController.state = homeController.state.copyWith(search: 'unknown');

      when(() => mockPokemonRepository.fetchPokemonDetail('unknown'))
          .thenAnswer((_) async => Either.left(const Failure.network()));

      // Act
      await homeController.searchPokemonFromAPI();

      // Assert
      expect(homeController.state.searchLoading, false);
      expect(homeController.state.searchResult, isEmpty);
      verify(() => mockPokemonRepository.fetchPokemonDetail('unknown')).called(1);
    });
  });

  group('HomeController - closeSession', () {
    test('Should call deviceRepository clear, writeString and delete',
        () async {
      // Arrange
      when(() => mockDeviceRepository.clear()).thenAnswer((_) async => {});
      when(() => mockDeviceRepository.writeString(
            key: any(named: 'key'),
            value: any(named: 'value'),
          )).thenAnswer((_) async => {});
      when(() => mockDeviceRepository.delete(key: any(named: 'key')))
          .thenAnswer((_) async => {});

      // Act
      await homeController.closeSession();

      // Assert
      verify(() => mockDeviceRepository.clear()).called(1);
      verify(() =>
              mockDeviceRepository.writeString(
                  key: 'device_token', value: ''))
          .called(1);
      verify(() => mockDeviceRepository.delete(key: 'device_token')).called(1);
    });
  });

  group('HomeController - Favorites', () {
    test('Should load favorites successfully and update state', () async {
      // Arrange
      final mockFavs = [
        PokemonModel(
            name: 'pikachu', url: 'https://pokeapi.co/api/v2/pokemon/25/'),
      ];
      when(() => mockPokemonRepository.getFavorites())
          .thenAnswer((_) async => mockFavs);

      // Act
      clearInteractions(mockPokemonRepository);
      await homeController.loadFavorites();

      // Assert
      expect(homeController.state.favorites, mockFavs);
      verify(() => mockPokemonRepository.getFavorites()).called(1);
    });

    test('Should call addFavorite when toggling a pokemon that is not favorite',
        () async {
      // Arrange
      final pokemon = PokemonModel(name: 'charmander', url: 'url');
      homeController.state = homeController.state.copyWith(favorites: []);
      when(() => mockPokemonRepository.addFavorite(pokemon))
          .thenAnswer((_) async => {});
      when(() => mockPokemonRepository.getFavorites())
          .thenAnswer((_) async => [pokemon]);

      // Act
      await homeController.toggleFavorite(pokemon);

      // Assert
      verify(() => mockPokemonRepository.addFavorite(pokemon)).called(1);
      verifyNever(() => mockPokemonRepository.removeFavorite(pokemon));
      expect(homeController.state.favorites, [pokemon]);
    });

    test(
        'Should call removeFavorite when toggling a pokemon that is already favorite',
        () async {
      // Arrange
      final pokemon = PokemonModel(name: 'charmander', url: 'url');
      homeController.state =
          homeController.state.copyWith(favorites: [pokemon]);
      when(() => mockPokemonRepository.removeFavorite(pokemon))
          .thenAnswer((_) async => {});
      when(() => mockPokemonRepository.getFavorites())
          .thenAnswer((_) async => []);

      // Act
      await homeController.toggleFavorite(pokemon);

      // Assert
      verify(() => mockPokemonRepository.removeFavorite(pokemon)).called(1);
      verifyNever(() => mockPokemonRepository.addFavorite(pokemon));
      expect(homeController.state.favorites, isEmpty);
    });

    test('Should toggle showFavoritesOnly and reset search state', () {
      // Arrange
      homeController.state = homeController.state.copyWith(
        showFavoritesOnly: false,
        search: 'pikachu',
        searchResult: [PokemonModel(name: 'pikachu', url: 'url')],
      );

      // Act
      homeController.toggleShowFavoritesOnly();

      // Assert
      expect(homeController.state.showFavoritesOnly, true);
      expect(homeController.state.search, isEmpty);
      expect(homeController.state.searchResult, isNull);

      // Act back
      homeController.toggleShowFavoritesOnly();

      // Assert back
      expect(homeController.state.showFavoritesOnly, false);
    });

    test('Should filter favorites locally when showFavoritesOnly is true and query is changed', () {
      // Arrange
      final pokemon1 = PokemonModel(name: 'pikachu', url: 'url');
      final pokemon2 = PokemonModel(name: 'charmander', url: 'url');
      homeController.state = homeController.state.copyWith(
        showFavoritesOnly: true,
        favorites: [pokemon1, pokemon2],
        search: '',
        searchResult: null,
      );

      // Act
      homeController.onSearchChanged('pika');

      // Assert
      expect(homeController.state.searchResult, [pokemon1]);

      // Act clear search
      homeController.onSearchChanged('');

      // Assert clear search
      expect(homeController.state.searchResult, isNull);
    });
  });
}

import 'package:flutter_meedu/providers.dart';
import 'package:flutter_meedu/notifiers.dart';
import 'package:poke_test/data/injects/repositories/app_inject_repositories.dart';
import 'package:poke_test/domain/repositories/index_repositories.dart';
import 'package:poke_test/domain/responses/pokemon_response_model.dart';

import 'home_state.dart';

final homeProvider = Provider.state<HomeController, HomeState>((_) {
  return HomeController(
    HomeState.initialState,
    pokemonRepository: AppInjectRepositories.pokemonRep.read(),
    deviceRepository: AppInjectRepositories.deviceRep.read(),
  );
});

class HomeController extends StateNotifier<HomeState> {
  HomeController(
    super.initialState, {
    required this._pokemonRepository,
    required this._deviceRepository,
  }) {
    loadPokemons();
    loadFavorites();
  }

  final PokemonRepository _pokemonRepository;
  final DeviceRepository _deviceRepository;

  Future<void> loadPokemons() async {
    state = state.copyWith(appViewStateUtil: .loading);

    final result = await _pokemonRepository.fetchAllPokemon(
      limit: state.limit,
      offset: 0,
    );

    result.fold(
      (failure) => state = state.copyWith(appViewStateUtil: .error),
      (pokemonsResp) => state = state.copyWith(
        appViewStateUtil: .success,
        pokemonResponse: pokemonsResp,
      ),
    );
  }

  Future<void> loadMorePokemons() async {
    final currentResponse = state.pokemonResponse;

    if (state.isLoadMore ||
        currentResponse == null ||
        currentResponse.next == null) {
      return;
    }

    state = state.copyWith(isLoadMore: true);

    final currentOffset = currentResponse.results.length;

    final result = await _pokemonRepository.fetchAllPokemon(
      limit: state.limit,
      offset: currentOffset,
    );

    result.fold((failure) => state = state.copyWith(isLoadMore: false), (
      newResponse,
    ) {
      final updatedResults = [
        ...currentResponse.results,
        ...newResponse.results,
      ];

      state = state.copyWith(
        isLoadMore: false,
        pokemonResponse: currentResponse.copyWith(
          next: newResponse.next,
          previous: newResponse.previous,
          results: updatedResults,
        ),
      );
    });
  }

  void onSearchChanged(String query) {
    state = state.copyWith(search: query);

    if (query.trim().isEmpty) {
      state = state.copyWith(searchResult: null);
      return;
    }

    final currentResponse = state.pokemonResponse;
    if (currentResponse == null) return;

    final localFiltered = currentResponse.results.where((pokemon) {
      return pokemon.name.toLowerCase().contains(query.toLowerCase().trim());
    }).toList();

    state = state.copyWith(searchResult: localFiltered);
  }

  Future<void> searchPokemonFromAPI() async {
    final query = state.search.trim().toLowerCase();
    if (query.isEmpty) return;

    state = state.copyWith(searchLoading: true);

    final result = await _pokemonRepository.fetchPokemonDetail(query);

    result.fold(
      (failure) {
        state = state.copyWith(searchLoading: false, searchResult: []);
      },
      (pokemonDetail) {
        final modelFromAPI = PokemonModel(
          name: pokemonDetail.name,
          url: 'https://pokeapi.co/api/v2/pokemon/${pokemonDetail.id}/',
        );

        state = state.copyWith(
          searchLoading: false,
          searchResult: [modelFromAPI],
        );
      },
    );
  }

  Future<void> loadFavorites() async {
    final favorites = await _pokemonRepository.getFavorites();
    state = state.copyWith(favorites: favorites);
  }

  Future<void> toggleFavorite(PokemonModel pokemon) async {
    final isFav = state.favorites.any((p) => p.name == pokemon.name);
    if (isFav) {
      await _pokemonRepository.removeFavorite(pokemon);
    } else {
      await _pokemonRepository.addFavorite(pokemon);
    }
    await loadFavorites();
  }

  Future<void> closeSession() async {
    await _deviceRepository.clear();
    await _deviceRepository.writeString(key: 'device_token', value: '');
    await _deviceRepository.delete(key: 'device_token');
  }
}

import 'package:flutter_meedu/providers.dart';
import 'package:flutter_meedu/notifiers.dart';
import 'package:poke_test/data/injects/repositories/app_inject_repositories.dart';
import 'package:poke_test/domain/repositories/pokemon/pokemon_repository.dart';
import 'pokemon_state.dart';

final pokemonDetailProvider =
    Provider.state<PokemonDetailController, PokemonState>(
      (_) => PokemonDetailController(
        PokemonState.initialState,
        pokemonRepository: AppInjectRepositories.pokemonRep.read(),
      ),
    );

class PokemonDetailController extends StateNotifier<PokemonState> {
  PokemonDetailController(
    super.initialState, {
    required this._pokemonRepository,
  });

  final PokemonRepository _pokemonRepository;

  void onChangeId(int id) async {
    state = state.copyWith(pokemonId: id);
  }

  void loadPokemon() async {
    state = state.copyWith(appViewStateUtil: .loading);

    final result = await _pokemonRepository.fetchPokemonDetail(
      state.pokemonId.toString(),
    );
    result.fold(
      (error) {
        state = state.copyWith(appViewStateUtil: .error);
      },
      (pokemon) {
        state = state.copyWith(
          pokemonId: pokemon.id,
          pokemon: pokemon,
          appViewStateUtil: .success,
        );
      },
    );
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poke_test/domain/models/pokemon_detail_model.dart';
import 'package:poke_test/presentation/globals/utils/app_view_state_util.dart';

part 'pokemon_state.freezed.dart';

@freezed
abstract class PokemonState with _$PokemonState {
  const PokemonState._();
  const factory PokemonState({
    int? pokemonId,
    PokemonDetailModel? pokemon,
    @Default(AppViewStateUtil.idle) AppViewStateUtil appViewStateUtil,
  }) = _PokemonState;

  static PokemonState get initialState => const PokemonState(pokemonId: null);
}

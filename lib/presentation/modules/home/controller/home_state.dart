import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poke_test/domain/responses/pokemon_response_model.dart';
import 'package:poke_test/presentation/globals/utils/app_view_state_util.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState({
    @Default('') String search,
    @Default(AppViewStateUtil.idle) AppViewStateUtil appViewStateUtil,
    @Default(false) bool isLoadMore,
    @Default(20) int limit,
    @Default(0) int offset,
    @Default(false) bool searchLoading,
    @Default([]) List<PokemonModel> favorites,
    PokemonResponseModel? pokemonResponse,
    List<PokemonModel>? searchResult,
  }) = _HomeState;

  static HomeState get initialState => HomeState(pokemonResponse: null);
}

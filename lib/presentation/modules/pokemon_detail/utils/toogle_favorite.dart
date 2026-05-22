import 'package:poke_test/domain/models/pokemon_detail_model.dart';
import 'package:poke_test/domain/responses/pokemon_response_model.dart';
import 'package:poke_test/presentation/globals/extensions/pokemon_detail_model_ext.dart';
import 'package:poke_test/presentation/modules/home/controller/home_controller.dart';

void toogleFavorite(PokemonDetailModel pokemon) {
  final pokemonModel = PokemonModel(
    name: pokemon.name,
    url: pokemon.shortImageUrl,
  );
  homeProvider.read().toggleFavorite(pokemonModel);
}

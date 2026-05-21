import 'package:poke_test/data/providers/pokemon/pokemon_provider.dart';
import 'package:poke_test/domain/models/eighter/typedefs.dart';
import 'package:poke_test/domain/models/failures/failure.dart';
import 'package:poke_test/domain/models/pokemon_detail_model.dart';
import 'package:poke_test/domain/repositories/pokemon/pokemon_repository.dart';
import 'package:poke_test/domain/responses/pokemon_response_model.dart';

class PokemonRepositoryImpl extends PokemonRepository {
  final PokemonProvider _pokemonProvider;

  PokemonRepositoryImpl({required this._pokemonProvider});

  @override
  FutureEither<Failure, PokemonResponseModel> fetchAllPokemon({
    int limit = 20,
    int offset = 0,
  }) async {
    return await _pokemonProvider.fetchAllPokemon(limit: limit, offset: offset);
  }

  @override
  FutureEither<Failure, PokemonDetailModel> fetchPokemonDetail(
    String idOrName,
  ) async {
    return await _pokemonProvider.fetchPokemonDetail(idOrName);
  }
}

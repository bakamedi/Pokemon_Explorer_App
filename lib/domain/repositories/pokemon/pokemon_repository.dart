import 'package:poke_test/domain/models/eighter/typedefs.dart';
import 'package:poke_test/domain/models/failures/failure.dart';
import 'package:poke_test/domain/models/pokemon_detail_model.dart';
import 'package:poke_test/domain/responses/pokemon_response_model.dart';

abstract class PokemonRepository {
  FutureEither<Failure, PokemonResponseModel> fetchAllPokemon({
    int limit = 20,
    int offset = 0,
  });
  FutureEither<Failure, PokemonDetailModel> fetchPokemonDetail(String idOrName);
}

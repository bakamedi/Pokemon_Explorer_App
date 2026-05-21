import 'package:poke_test/data/helpers/http/http_helper.dart';
import 'package:poke_test/domain/models/eighter/typedefs.dart';
import 'package:poke_test/domain/models/failures/failure.dart';
import 'package:poke_test/domain/models/pokemon_detail_model.dart';
import 'package:poke_test/domain/responses/pokemon_response_model.dart';

class PokemonProvider {
  final HttpHelper _httpHelper;
  final String _basePath;

  PokemonProvider({required this._httpHelper, required this._basePath});

  FutureEither<Failure, PokemonResponseModel> fetchAllPokemon({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final result = await _httpHelper.request(
        '$_basePath?limit=$limit&offset=$offset',
        headers: {
          'Content-Type': 'application/json',
        },
        parser: (responseData) {
          return PokemonResponseModel.fromJson(responseData);
        },
      );

      return result.fold(
        (failure) => .left(failure),
        (response) => .right(response),
      );
    } catch (e) {
      return .left(.network(message: 'Error en provider: ${e.toString()}'));
    }
  }

  FutureEither<Failure, PokemonDetailModel> fetchPokemonDetail(
    String idOrName,
  ) async {
    try {
      final result = await _httpHelper.request(
        '$_basePath/$idOrName',
        headers: {
          'Content-Type': 'application/json',
        },
        parser: (responseData) {
          return PokemonDetailModel.fromJson(responseData);
        },
      );

      return result.fold(
        (failure) => .left(failure),
        (response) => .right(response),
      );
    } catch (e) {
      return .left(.network(message: 'Error en provider: ${e.toString()}'));
    }
  }
}

import 'dart:convert';
import 'package:poke_test/data/providers/pokemon/pokemon_provider.dart';
import 'package:poke_test/domain/models/eighter/typedefs.dart';
import 'package:poke_test/domain/models/failures/failure.dart';
import 'package:poke_test/domain/models/pokemon_detail_model.dart';
import 'package:poke_test/domain/repositories/device/device_repository.dart';
import 'package:poke_test/domain/repositories/pokemon/pokemon_repository.dart';
import 'package:poke_test/domain/responses/pokemon_response_model.dart';

class PokemonRepositoryImpl extends PokemonRepository {
  final PokemonProvider _pokemonProvider;
  final DeviceRepository _deviceRepository;

  PokemonRepositoryImpl({
    required this._pokemonProvider,
    required this._deviceRepository,
  });

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

  static const _favoritesKey = 'favorites_pokemon';

  @override
  Future<List<PokemonModel>> getFavorites() async {
    final jsonString = await _deviceRepository.readString(key: _favoritesKey);
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded
          .map((item) => PokemonModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> addFavorite(PokemonModel pokemon) async {
    final favorites = await getFavorites();
    if (!favorites.any((p) => p.name == pokemon.name)) {
      final updated = [...favorites, pokemon];
      final jsonString = jsonEncode(updated.map((p) => p.toJson()).toList());
      await _deviceRepository.writeString(
        key: _favoritesKey,
        value: jsonString,
      );
    }
  }

  @override
  Future<void> removeFavorite(PokemonModel pokemon) async {
    final favorites = await getFavorites();
    final updated = favorites.where((p) => p.name != pokemon.name).toList();
    final jsonString = jsonEncode(updated.map((p) => p.toJson()).toList());
    await _deviceRepository.writeString(key: _favoritesKey, value: jsonString);
  }
}

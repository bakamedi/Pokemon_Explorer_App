import 'package:poke_test/domain/responses/pokemon_response_model.dart';

extension PokemonModelExt on PokemonModel {
  String get imageUrl {
    // Extraemos el ID del Pokémon de la URL
    final id = url.split('/').where((part) => part.isNotEmpty).last;
    // Construimos la URL de la imagen usando el ID
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
  }

  int get pokemonId {
    if (url.isEmpty) return 1;
    // Remueve el '/' del final si existe (ej: "https://pokeapi.co/api/v2/pokemon/25/")
    final cleanUrl = url.endsWith('/') ? url.substring(0, url.length - 1) : url;
    // Toma el último segmento que es el ID y lo parsea a int
    final idString = cleanUrl.split('/').last;
    return int.tryParse(idString) ?? 1;
  }

  String get pokemonNumber {
    if (url.isEmpty) return '#000';
    final cleanUrl = url.endsWith('/') ? url.substring(0, url.length - 1) : url;
    final idString = cleanUrl.split('/').last;

    // Convierte a entero y lo formatea con ceros a la izquierda (mínimo 3 dígitos)
    final id = int.tryParse(idString) ?? 0;
    return '#${id.toString().padLeft(3, '0')}';
  }
}

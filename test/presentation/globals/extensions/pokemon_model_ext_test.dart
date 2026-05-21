import 'package:flutter_test/flutter_test.dart';
import 'package:poke_test/domain/responses/pokemon_response_model.dart';
import 'package:poke_test/presentation/globals/extensions/pokemon_model_ext.dart';

void main() {
  group('PokemonModelExt', () {
    test('imageUrl extracts ID and constructs sprite URL', () {
      const model = PokemonModel(name: 'bulbasaur', url: 'https://pokeapi.co/api/v2/pokemon/1/');
      expect(model.imageUrl, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png');
      
      const modelNoSlash = PokemonModel(name: 'bulbasaur', url: 'https://pokeapi.co/api/v2/pokemon/1');
      expect(modelNoSlash.imageUrl, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png');
    });

    test('pokemonId returns parsed ID from URL or default of 1', () {
      const model = PokemonModel(name: 'pikachu', url: 'https://pokeapi.co/api/v2/pokemon/25/');
      expect(model.pokemonId, 25);

      const modelNoSlash = PokemonModel(name: 'pikachu', url: 'https://pokeapi.co/api/v2/pokemon/25');
      expect(modelNoSlash.pokemonId, 25);

      const emptyModel = PokemonModel(name: 'unknown', url: '');
      expect(emptyModel.pokemonId, 1);

      const badUrlModel = PokemonModel(name: 'unknown', url: 'https://pokeapi.co/api/v2/pokemon/abc');
      expect(badUrlModel.pokemonId, 1);
    });

    test('pokemonNumber returns formatted number with at least 3 digits', () {
      const model = PokemonModel(name: 'pikachu', url: 'https://pokeapi.co/api/v2/pokemon/25/');
      expect(model.pokemonNumber, '#025');

      const modelSingle = PokemonModel(name: 'bulbasaur', url: 'https://pokeapi.co/api/v2/pokemon/1/');
      expect(modelSingle.pokemonNumber, '#001');

      const modelLarge = PokemonModel(name: 'pecharunt', url: 'https://pokeapi.co/api/v2/pokemon/1025/');
      expect(modelLarge.pokemonNumber, '#1025');

      const emptyModel = PokemonModel(name: 'unknown', url: '');
      expect(emptyModel.pokemonNumber, '#000');
    });
  });
}

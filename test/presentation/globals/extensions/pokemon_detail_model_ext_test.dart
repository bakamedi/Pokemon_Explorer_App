import 'package:flutter_test/flutter_test.dart';
import 'package:poke_test/domain/models/pokemon_detail_model.dart';
import 'package:poke_test/presentation/globals/extensions/pokemon_detail_model_ext.dart';

void main() {
  group('PokemonDetailModelExt', () {
    const detailModel = PokemonDetailModel(
      id: 25,
      name: 'pikachu',
      height: 4, // 0.4 m
      weight: 60, // 6.0 kg
      types: [
        TypeSlot(
          slot: 1,
          type: NamedAPIResource(name: 'electric', url: 'https://pokeapi.co/api/v2/type/13/'),
        ),
      ],
      abilities: [],
      stats: [],
    );

    test('weightInKg returns properly formatted string', () {
      expect(detailModel.weightInKg, '6.0 kg');
    });

    test('heightInM returns properly formatted string', () {
      expect(detailModel.heightInM, '0.4 m');
    });

    test('formattedId returns padded 3-digit id string', () {
      expect(detailModel.formattedId, '#025');
      
      const singleDigitModel = PokemonDetailModel(
        id: 4,
        name: 'charmander',
        height: 6,
        weight: 85,
        types: [],
        abilities: [],
        stats: [],
      );
      expect(singleDigitModel.formattedId, '#004');

      const fourDigitModel = PokemonDetailModel(
        id: 1025,
        name: 'pecharunt',
        height: 3,
        weight: 3,
        types: [],
        abilities: [],
        stats: [],
      );
      expect(fourDigitModel.formattedId, '#1025');
    });

    test('imageUrl returns correct official artwork URL', () {
      expect(
        detailModel.imageUrl,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png',
      );
    });
  });
}

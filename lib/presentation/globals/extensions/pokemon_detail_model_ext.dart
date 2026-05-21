import 'package:poke_test/domain/models/pokemon_detail_model.dart';

extension PokemonDetailModelExt on PokemonDetailModel {
String get weightInKg => '${(weight / 10).toStringAsFixed(1)} kg';

String get heightInM => '${(height / 10).toStringAsFixed(1)} m';

  String get formattedId => '#${id.toString().padLeft(3, '0')}';

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
}

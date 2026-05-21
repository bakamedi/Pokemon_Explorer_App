import 'package:flutter/material.dart';

extension PokemonStringExt on String {
  /// Abrevia los nombres de los stats que devuelve la PokeAPI (ej: 'special-attack' -> 'SATK')
  String get abbreviatePokemonStat {
    switch (toLowerCase()) {
      case 'hp':
        return 'HP';
      case 'attack':
        return 'ATK';
      case 'defense':
        return 'DEF';
      case 'special-attack':
        return 'SATK';
      case 'special-defense':
        return 'SDEF';
      case 'speed':
        return 'SPD';
      default:
        return toUpperCase();
    }
  }

  /// Devuelve el color representativo de cada tipo elemental de Pokémon
  Color get toPokemonTypeColor {
    switch (toLowerCase()) {
      case 'fire':
        return Colors.orange;
      case 'water':
        return Colors.blue;
      case 'grass':
        return Colors.green;
      case 'electric':
        return Colors.amber;
      case 'poison':
        return Colors.purple;
      case 'flying':
        return Colors.indigo.shade300;
      case 'bug':
        return Colors.lightGreen.shade600;
      case 'normal':
        return Colors.grey.shade400;
      default:
        return Colors.blueGrey.shade300;
    }
  }
}
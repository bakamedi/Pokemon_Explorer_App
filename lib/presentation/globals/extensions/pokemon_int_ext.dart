import 'package:flutter/material.dart';

extension PokemonIntExt on int {
  Color get toPokemonStatColor {
    if (this < 50) return Colors.red.shade400;
    if (this < 90) return Colors.orange.shade400;
    return Colors.green.shade400;
  }
}
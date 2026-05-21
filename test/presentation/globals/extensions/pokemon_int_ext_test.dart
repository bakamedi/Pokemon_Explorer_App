import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_test/presentation/globals/extensions/pokemon_int_ext.dart';

void main() {
  group('PokemonIntExt', () {
    test('should return red for values less than 50', () {
      expect(0.toPokemonStatColor, Colors.red.shade400);
      expect(49.toPokemonStatColor, Colors.red.shade400);
    });

    test('should return orange for values between 50 and 89', () {
      expect(50.toPokemonStatColor, Colors.orange.shade400);
      expect(89.toPokemonStatColor, Colors.orange.shade400);
    });

    test('should return green for values 90 or greater', () {
      expect(90.toPokemonStatColor, Colors.green.shade400);
      expect(150.toPokemonStatColor, Colors.green.shade400);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_test/presentation/globals/extensions/pokemon_string_ext.dart';

void main() {
  group('PokemonStringExt - abbreviatePokemonStat', () {
    test('should abbreviate common stats correctly case insensitively', () {
      expect('hp'.abbreviatePokemonStat, 'HP');
      expect('HP'.abbreviatePokemonStat, 'HP');
      expect('attack'.abbreviatePokemonStat, 'ATK');
      expect('defense'.abbreviatePokemonStat, 'DEF');
      expect('special-attack'.abbreviatePokemonStat, 'SATK');
      expect('special-defense'.abbreviatePokemonStat, 'SDEF');
      expect('speed'.abbreviatePokemonStat, 'SPD');
    });

    test('should capitalize default unrecognized stats', () {
      expect('unknown-stat'.abbreviatePokemonStat, 'UNKNOWN-STAT');
    });
  });

  group('PokemonStringExt - toPokemonTypeColor', () {
    test('should return correct color for known types case insensitively', () {
      expect('fire'.toPokemonTypeColor, Colors.orange);
      expect('FIRE'.toPokemonTypeColor, Colors.orange);
      expect('water'.toPokemonTypeColor, Colors.blue);
      expect('grass'.toPokemonTypeColor, Colors.green);
      expect('electric'.toPokemonTypeColor, Colors.amber);
      expect('poison'.toPokemonTypeColor, Colors.purple);
      expect('flying'.toPokemonTypeColor, Colors.indigo.shade300);
      expect('bug'.toPokemonTypeColor, Colors.lightGreen.shade600);
      expect('normal'.toPokemonTypeColor, Colors.grey.shade400);
    });

    test('should return blueGrey for default unknown types', () {
      expect('dragon'.toPokemonTypeColor, Colors.blueGrey.shade300);
    });
  });
}

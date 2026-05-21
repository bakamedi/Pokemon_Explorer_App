import 'package:flutter/material.dart';
import 'package:poke_test/domain/models/pokemon_detail_model.dart'; // Tu ruta real del modelo
import 'package:poke_test/presentation/globals/extensions/pokemon_string_ext.dart'; // Tu ruta real de la extensión

class PokemonTypesW extends StatelessWidget {
  const PokemonTypesW({super.key, required this.types});

  final List<TypeSlot> types;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: types.map((typeSlot) {
        return Chip(
          label: Text(
            typeSlot.type.name.toUpperCase(),
            style: const TextStyle(color: Colors.white, fontWeight: .bold),
          ),
          backgroundColor: typeSlot.type.name.toPokemonTypeColor,
          side: .none,
          shape: RoundedRectangleBorder(borderRadius: .circular(12)),
        );
      }).toList(),
    );
  }
}

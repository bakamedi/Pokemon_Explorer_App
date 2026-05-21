import 'package:flutter/material.dart';
import 'package:poke_test/domain/models/pokemon_detail_model.dart';

class PokemonAbilitiesW extends StatelessWidget {
  const PokemonAbilitiesW({super.key, required this.abilities});

  final List<AbilitySlot> abilities;

  @override
  Widget build(BuildContext context) {
    return Column(
crossAxisAlignment: .start,
      spacing: 8,
      children: [
        // --- SECCIÓN DE HABILIDADES ---
        const Text(
          'ABILITIES',
          style: TextStyle(
            fontWeight: .bold,
            letterSpacing: 1.0,
            color: Colors.grey,
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: abilities.map((abilitySlot) {
            return Container(
              padding: const .symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: .circular(10),
                border: .all(color: Colors.grey.shade200),
              ),
              child: Text(
                abilitySlot.ability.name.replaceAll('-', ' ').toUpperCase(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: .w600,
                  color: abilitySlot.isHidden
                      ? Colors.blueGrey
                      : Colors.black87,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

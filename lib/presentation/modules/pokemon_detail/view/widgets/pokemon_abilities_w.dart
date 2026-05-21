import 'package:flutter/material.dart';
import 'package:poke_test/domain/models/pokemon_detail_model.dart';
import 'package:poke_test/theme/app_colors.dart';

class PokemonAbilitiesW extends StatelessWidget {
  const PokemonAbilitiesW({
    super.key,
    required this.abilities,
    required this.isDarkMode,
  });

  final List<AbilitySlot> abilities;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        Text(
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
                color: isDarkMode ? AppColors.darkInput : Colors.white,
                borderRadius: .circular(10),
                border: .all(color: Colors.grey.shade200),
              ),
              child: Text(
                abilitySlot.ability.name.replaceAll('-', ' ').toUpperCase(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: .w600,
                  color: isDarkMode
                      ? Colors.white
                      : abilitySlot.isHidden
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

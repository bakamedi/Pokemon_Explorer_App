import 'package:flutter/material.dart';
import 'package:poke_test/domain/models/pokemon_detail_model.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
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
      spacing: 8.rh,
      children: [
        Text(
          'ABILITIES',
          style: TextStyle(
            fontWeight: .bold,
            fontSize: 12.sp,
            letterSpacing: 1.0,
            color: Colors.grey,
          ),
        ),
        Wrap(
          spacing: 8.rw,
          runSpacing: 8.rh,
          children: abilities.map((abilitySlot) {
            return Container(
              padding: .symmetric(horizontal: 12.rw, vertical: 8.rh),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.darkInput : Colors.white,
                borderRadius: .circular(10.rw),
                border: .all(color: Colors.grey.shade200),
              ),
              child: Text(
                abilitySlot.ability.name.replaceAll('-', ' ').toUpperCase(),
                style: TextStyle(
                  fontSize: 13.sp,
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

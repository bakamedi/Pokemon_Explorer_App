import 'package:flutter/material.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/presentation/modules/pokemon_detail/view/widgets/info_card_w.dart';

class PokemonDimensionsW extends StatelessWidget {
  const PokemonDimensionsW({
    super.key,
    required this.weightInKg,
    required this.heightInM,
    required this.isDarkMode,
  });

  final String weightInKg;
  final String heightInM;

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InfoCardW(
          icon: Icons.scale_outlined,
          title: 'WEIGHT',
          value: weightInKg,
          isDarkMode: isDarkMode,
        ),
        16.rw.w,
        InfoCardW(
          icon: Icons.height_outlined,
          title: 'HEIGHT',
          value: heightInM,
          isDarkMode: isDarkMode,
        ),
      ],
    );
  }
}

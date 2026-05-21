import 'package:flutter/material.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/presentation/modules/pokemon_detail/view/widgets/info_card_w.dart';

class PokemonDimensionsW extends StatelessWidget {
  const PokemonDimensionsW({
    super.key,
    required this.weightInKg,
    required this.heightInM,
  });

  final String weightInKg;
  final String heightInM;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InfoCardW(
          icon: Icons.scale_outlined,
          title: 'WEIGHT',
          value: weightInKg,
        ),
        16.w,
        InfoCardW(
          icon: Icons.height_outlined,
          title: 'HEIGHT',
          value: heightInM,
        ),
      ],
    );
  }
}

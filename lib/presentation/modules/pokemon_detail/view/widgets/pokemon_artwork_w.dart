import 'package:flutter/material.dart';
import 'package:poke_test/domain/models/pokemon_detail_model.dart';
import 'package:poke_test/presentation/globals/common/widgets/cache_image_gw.dart';
import 'package:poke_test/presentation/globals/extensions/pokemon_detail_model_ext.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/theme/app_colors.dart'; // Tu ruta real del modelo

class PokemonArtworkW extends StatelessWidget {
  const PokemonArtworkW({
    super.key,
    required this.pokemon,
    required this.isDarkMode,
  });

  final PokemonDetailModel pokemon;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .infinity,
      height: 200,
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkInput : Colors.purple.shade50,
        borderRadius: .circular(24),
      ),
      padding: const .all(16),
      child: CacheImageGW(
        imageUrl: pokemon.imageUrl,
        fit: .contain,
        width: 100.rw,
        height: 100.rh,
      ),
    ).center;
  }
}

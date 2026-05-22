import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer/consumer_widget.dart';
import 'package:flutter_meedu/provider/filters.dart';
import 'package:poke_test/domain/responses/pokemon_response_model.dart';
import 'package:poke_test/presentation/globals/common/widgets/cache_image_gw.dart';
import 'package:poke_test/presentation/globals/controllers/settings/settings_gc.dart';
import 'package:poke_test/presentation/globals/extensions/pokemon_model_ext.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/presentation/modules/home/controller/home_controller.dart';
import 'package:poke_test/presentation/modules/home/utils/go_to_pokemon.dart';
import 'package:poke_test/presentation/modules/home/view/widgets/home_favorite_w.dart';
import 'package:poke_test/theme/app_colors.dart';

class ItemHomeW extends StatelessWidget {
  const ItemHomeW({super.key, required this.pokemon});

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, _) {
        final isDarkMode = ref.select(settingsGP.select((s) => s.isDarkMode));
        final isFavorite = ref.select(
          homeProvider.select(
            (s) => s.favorites.any((p) => p.name == pokemon.name),
          ),
        );

        return GestureDetector(
          onTap: () => goToPokemon(pokemon.pokemonId),
          child: Container(
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.darkCard : Colors.white,
              borderRadius: .circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const .all(16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: .infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? AppColors.darkInput
                            : Colors.purple.shade50,
                        borderRadius: .circular(16),
                      ),
                      child: CacheImageGW(
                        imageUrl: pokemon.imageUrl,
                        width: 400.rw,
                        height: 400.rh,
                        fit: .contain,
                      ),
                    ),

                    HomeFavoriteW(
                      isFavorite: isFavorite,
                      isDarkMode: isDarkMode,
                      onTap: () {
                        homeProvider.read().toggleFavorite(pokemon);
                      },
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const .symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? AppColors.darkTextSecondary
                              : Colors.black.withValues(alpha: 0.08),
                          borderRadius: .circular(12),
                        ),
                        child: Text(
                          pokemon.pokemonNumber,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: .bold,
                            color: isDarkMode
                                ? AppColors.darkTextPrimary
                                : Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                16.h,

                Text(
                  pokemon.name.toUpperCase(),
                  maxLines: 1,
                  overflow: .ellipsis,
                  style: TextStyle(
                    color: isDarkMode
                        ? AppColors.darkTextPrimary
                        : Colors.grey.shade900,
                    fontSize: 15.sp,
                    fontWeight: .bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

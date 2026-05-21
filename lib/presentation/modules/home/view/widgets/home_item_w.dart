import 'package:flutter/material.dart';
import 'package:poke_test/domain/responses/pokemon_response_model.dart';
import 'package:poke_test/presentation/globals/common/widgets/cache_image_gw.dart';
import 'package:poke_test/presentation/globals/extensions/pokemon_model_ext.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/presentation/modules/home/utils/go_to_pokemon.dart';

class ItemHomeW extends StatelessWidget {
  const ItemHomeW({super.key, required this.pokemon});

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goToPokemon(pokemon.pokemonId),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
                    color: Colors.purple.shade50,
                    borderRadius: .circular(16),
                  ),
                  child: CacheImageGW(
                    imageUrl: pokemon.imageUrl,
                    width: 400.rw,
                    height: 400.rh,
                    fit: .contain,
                  ),
                ),

                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const .symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.08),
                      borderRadius: .circular(12),
                    ),
                    child: Text(
                      pokemon.pokemonNumber,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: .bold,
                        color: Colors.grey.shade800,
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
              style: const TextStyle(
                fontSize: 15,
                fontWeight: .bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

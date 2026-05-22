import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';
import 'package:flutter_meedu/provider/filters.dart';
import 'package:poke_test/presentation/globals/common/widgets/app_state_wrapper_gw.dart';
import 'package:poke_test/presentation/globals/controllers/settings/settings_gc.dart';
import 'package:poke_test/presentation/globals/extensions/pokemon_detail_model_ext.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/presentation/modules/pokemon_detail/controller/pokemon_detail_controller.dart';
import 'package:poke_test/presentation/modules/pokemon_detail/utils/toogle_favorite.dart';
import 'package:poke_test/presentation/modules/pokemon_detail/view/widgets/pokemon_abilities_w.dart';
import 'package:poke_test/presentation/modules/pokemon_detail/view/widgets/pokemon_artwork_w.dart';
import 'package:poke_test/presentation/modules/pokemon_detail/view/widgets/pokemon_base_stats_w.dart';
import 'package:poke_test/presentation/modules/pokemon_detail/view/widgets/pokemon_detail_loading_page_w.dart';
import 'package:poke_test/presentation/modules/pokemon_detail/view/widgets/pokemon_dimensions_w.dart';
import 'package:poke_test/presentation/modules/pokemon_detail/view/widgets/pokemon_types_w.dart';
import 'package:poke_test/presentation/modules/home/controller/home_controller.dart';
import 'package:poke_test/theme/app_colors.dart';

class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({super.key, required this.pokemonId});

  final int pokemonId;

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  @override
  void initState() {
    super.initState();

    final controller = pokemonDetailProvider.read();
    controller.onChangeId(widget.pokemonId);
    controller.loadPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Consumer(
        builder: (_, ref, _) {
          final controller = ref.watch(pokemonDetailProvider);
          final isDarkMode = ref.select(settingsGP.select((s) => s.isDarkMode));

          return AppStateWrapperGW(
            appViewStateUtil: controller.state.appViewStateUtil,
            loadingWidget: const PokemonDetailLoadingPageW(),
            onSuccess: (_) {
              final pokemon = controller.state.pokemon;

              if (pokemon == null) {
                return Text('No se encontraron detalles del pokemon.').center;
              }

              final isFavorite = ref.select(
                homeProvider.select(
                  (s) => s.favorites.any((p) => p.name == pokemon.name),
                ),
              );

              return Scaffold(
                backgroundColor: isDarkMode
                    ? AppColors.darkBackground
                    : AppColors.lightBackground,
                appBar: AppBar(
                  title: Text(
                    '${pokemon.name.toUpperCase()} ${pokemon.formattedId}',
                    style: TextStyle(fontWeight: .bold, fontSize: 18.sp),
                  ),
                  centerTitle: true,
                  backgroundColor: isDarkMode
                      ? AppColors.darkBackground
                      : Colors.grey[100],
                  foregroundColor: isDarkMode ? Colors.white : Colors.black,
                  elevation: 0,
                  actions: [
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.star : Icons.star_border,
                        color: isFavorite
                            ? Colors.amber
                            : (isDarkMode ? Colors.white70 : Colors.black87),
                      ),
                      onPressed: () => toogleFavorite(pokemon),
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  padding: .symmetric(horizontal: 20.rw, vertical: 20.rh),
                  child: Column(
                    spacing: 24.rh,
                    crossAxisAlignment: .start,
                    children: [
                      PokemonArtworkW(pokemon: pokemon, isDarkMode: isDarkMode),
                      PokemonTypesW(types: pokemon.types),
                      PokemonDimensionsW(
                        weightInKg: pokemon.weightInKg,
                        heightInM: pokemon.heightInM,
                        isDarkMode: isDarkMode,
                      ),
                      PokemonAbilitiesW(
                        abilities: pokemon.abilities,
                        isDarkMode: isDarkMode,
                      ),
                      PokemonBaseStatsW(
                        stats: pokemon.stats,
                        isDarkMode: isDarkMode,
                      ),
                      20.rh.h,
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

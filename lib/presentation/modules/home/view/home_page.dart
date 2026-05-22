import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';
import 'package:flutter_meedu/provider/filters.dart';
import 'package:poke_test/presentation/globals/common/widgets/app_state_wrapper_gw.dart';
import 'package:poke_test/presentation/globals/common/widgets/star_switch_gw.dart';
import 'package:poke_test/presentation/globals/controllers/settings/settings_gc.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/presentation/modules/home/controller/home_controller.dart';
import 'package:poke_test/presentation/modules/home/view/widgets/settings_w.dart';
import 'package:poke_test/presentation/modules/home/view/widgets/home_body_w.dart';
import 'package:poke_test/presentation/modules/home/view/widgets/home_loading_body_w.dart';
import 'package:poke_test/presentation/modules/home/view/widgets/home_search_w.dart';
import 'package:poke_test/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, _) {
        final isDarkMode = ref.select(settingsGP.select((s) => s.isDarkMode));
        final controller = ref.watch(homeProvider);
        final pokemonState = controller.state;

        return Scaffold(
          backgroundColor: isDarkMode
              ? AppColors.darkBackground
              : Colors.grey[100],
          appBar: AppBar(
            title: const Text('Pokémon Explorer App'),
            backgroundColor: isDarkMode
                ? AppColors.darkHeader
                : AppColors.primaryRed,
            actions: [const SettingsW(), 8.h],
          ),
          body: AppStateWrapperGW(
            appViewStateUtil: pokemonState.appViewStateUtil,
            loadingWidget: const HomeLoadingBodyW(),
            onSuccess: (context) {
              final resultsLength =
                  pokemonState.pokemonResponse?.results.length ?? 0;
              final totalCount = pokemonState.pokemonResponse?.count ?? 0;

              return Column(
                crossAxisAlignment: .start,
                children: [
                  const HomeSearchW(),
                  24.h,

                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        pokemonState.showFavoritesOnly
                            ? 'Favoritos (${pokemonState.favorites.length})'
                            : 'POKÉMON Disponibles ($resultsLength-$totalCount)',
                        style: TextStyle(
                          color: isDarkMode
                              ? AppColors.darkTextPrimary
                              : Colors.black,
                          fontWeight: .bold,
                          letterSpacing: .5,
                        ),
                      ),
                      StarSwitchGW(
                        value: pokemonState.showFavoritesOnly,
                        onChanged: (value) {
                          homeProvider.read().toggleShowFavoritesOnly();
                        },
                      ),
                    ],
                  ),
                  16.h,

                  if (pokemonState.showFavoritesOnly)
                    if (pokemonState.searchResult != null)
                      if (pokemonState.searchResult!.isNotEmpty)
                        HomeBodyW(result: pokemonState.searchResult)
                      else
                        _buildNoResultsWidget(
                          context,
                          isDarkMode,
                          pokemonState.search,
                          isFavorites: true,
                        )
                    else if (pokemonState.favorites.isEmpty)
                      Center(
                        child: Column(
                          mainAxisAlignment: .center,
                          children: [
                            40.h,
                            Icon(
                              Icons.star_border,
                              size: 64,
                              color: isDarkMode
                                  ? Colors.white30
                                  : Colors.black26,
                            ),
                            16.h,
                            Text(
                              'Aún no tienes favoritos',
                              style: TextStyle(
                                fontSize: 16,
                                color: isDarkMode
                                    ? Colors.white70
                                    : Colors.black54,
                                fontWeight: .w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      HomeBodyW(result: pokemonState.favorites)
                  else if (pokemonState.pokemonResponse != null)
                    if (pokemonState.searchResult != null)
                      if (pokemonState.searchResult!.isNotEmpty)
                        HomeBodyW(result: pokemonState.searchResult)
                      else
                        _buildNoResultsWidget(
                          context,
                          isDarkMode,
                          pokemonState.search,
                          isFavorites: false,
                        )
                    else
                      HomeBodyW(result: pokemonState.pokemonResponse!.results)
                  else
                    const SizedBox.shrink(),
                ],
              ).padding(
                const .symmetric(
                  horizontal: 16,
                  vertical: 16,
                ), // Corregido .symmetric
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildNoResultsWidget(
    BuildContext context,
    bool isDarkMode,
    String searchQuery, {
    required bool isFavorites,
  }) {
    return Expanded(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppColors.darkCard
                      : Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode
                          ? Colors.black26
                          : Colors.grey.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  isFavorites
                      ? Icons.star_outline_rounded
                      : Icons.search_off_rounded,
                  size: 80,
                  color: AppColors.primaryRed.withOpacity(0.8),
                ),
              ),
              24.h,
              Text(
                'No se encontraron Pokémon',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),
              8.h,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  isFavorites
                      ? 'No tienes ningún Pokémon favorito que coincida con "$searchQuery".'
                      : 'No pudimos encontrar ningún Pokémon que coincida con "$searchQuery".',
                  textAlign: .center,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
              ),
              if (!isFavorites) ...[
                24.h,
                ElevatedButton.icon(
                  onPressed: () {
                    homeProvider.read().searchPokemonFromAPI();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryRed,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  icon: const Icon(Icons.cloud_download_rounded, size: 20),
                  label: const Text(
                    'Buscar en PokeAPI',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

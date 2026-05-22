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
                      HomeBodyW(result: pokemonState.searchResult)
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
                    if (pokemonState.searchResult != null &&
                        pokemonState.searchResult!.isNotEmpty)
                      HomeBodyW(result: pokemonState.searchResult)
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
}

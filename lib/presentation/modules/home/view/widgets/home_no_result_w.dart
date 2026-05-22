import 'package:flutter/material.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart'; // Asegúrate de ajustar esta ruta según tus extensiones de tamaño (.h)
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/presentation/modules/home/controller/home_controller.dart';
import 'package:poke_test/theme/app_colors.dart';

class HomeNoResultW extends StatelessWidget {
  final bool isDarkMode;
  final bool isFavorites;
  final String searchQuery;

  const HomeNoResultW({
    super.key,
    required this.isDarkMode,
    required this.isFavorites,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Container(
            padding: const .all(24),
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.darkCard : Colors.white,
              shape: .circle,
              boxShadow: [
                BoxShadow(
                  color: isDarkMode
                      ? Colors.black26
                      : Colors.grey.withValues(alpha: .1),
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
              color: AppColors.primaryRed.withValues(alpha: .8),
            ),
          ),
          24.h,
          Text(
            'No se encontraron Pokémon',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: .bold,
              color: isDarkMode
                  ? AppColors.darkTextPrimary
                  : AppColors.lightTextPrimary,
            ),
          ),
          8.h,
          Text(
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
          ).padding(.symmetric(horizontal: 32.0)),
          if (!isFavorites) ...[
            24.h,
            ElevatedButton.icon(
              onPressed: () {
                homeProvider.read().searchPokemonFromAPI();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryRed,
                foregroundColor: Colors.white,
                padding: const .symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: .circular(12),
                ),
                elevation: 2,
              ),
              icon:  Icon(Icons.cloud_download_rounded, size: 20.sp),
              label:  Text(
                'Buscar en PokeAPI',
                style: TextStyle(
                  fontWeight: .bold,
                  letterSpacing: .5.sp,
                ),
              ),
            ),
          ],
        ],
      ),
    ).center.expanded;
  }
}

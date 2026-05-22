import 'package:flutter/material.dart';
import 'package:poke_test/domain/models/pokemon_detail_model.dart';
import 'package:poke_test/presentation/globals/extensions/pokemon_int_ext.dart';
import 'package:poke_test/presentation/globals/extensions/pokemon_string_ext.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/theme/app_colors.dart'; // Tu ruta real del modelo

class PokemonBaseStatsW extends StatelessWidget {
  const PokemonBaseStatsW({
    super.key,
    required this.stats,
    required this.isDarkMode,
  });

  // Pasamos únicamente la lista de stats para mantener el componente desacoplado
  final List<StatSlot> stats;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .symmetric(horizontal: 16.rw, vertical: 16.rh),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkInput : Colors.white,
        borderRadius: .circular(16.rw),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: stats.map((statSlot) {
          return Padding(
            padding: .symmetric(vertical: 6.rh),
            child: Row(
              children: [
                SizedBox(
                  width: 80.rw,
                  child: Text(
                    statSlot.stat.name.abbreviatePokemonStat,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: .w600,
                      color: isDarkMode ? Colors.white : Colors.black54,
                    ),
                  ),
                ),

                // Valor Numérico Base del Stat
                SizedBox(
                  width: 35.rw,
                  child: Text(
                    '${statSlot.baseStat}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: .bold,
                      color: isDarkMode ? Colors.white : Colors.black54,
                    ), // Corregido .bold
                  ),
                ),

                // Barra de Progreso Visual Eficiente
                Expanded(
                  // Es mejor usar el widget Expanded directamente rodeando al ClipRRect en vez de la extensión .expanded para evitar problemas de maquetación en Rows nativos
                  child: ClipRRect(
                    borderRadius: .circular(4.rw),
                    child: LinearProgressIndicator(
                      value: statSlot.baseStat / 255,
                      backgroundColor: Colors.grey.shade100,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        statSlot.baseStat.toPokemonStatColor,
                      ),
                      minHeight: 8.rh,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

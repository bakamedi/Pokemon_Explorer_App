import 'package:flutter/material.dart';
import 'package:poke_test/domain/models/pokemon_detail_model.dart';
import 'package:poke_test/presentation/globals/extensions/pokemon_int_ext.dart';
import 'package:poke_test/presentation/globals/extensions/pokemon_string_ext.dart';
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
      padding: const .all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkInput : Colors.white,
        borderRadius: .circular(16),
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
            padding: const .symmetric(vertical: 6.0),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    statSlot.stat.name.abbreviatePokemonStat,
                    style: TextStyle(
                      fontWeight: .w600,
                      color: isDarkMode ? Colors.white : Colors.black54,
                    ),
                  ),
                ),

                // Valor Numérico Base del Stat
                SizedBox(
                  width: 35,
                  child: Text(
                    '${statSlot.baseStat}',
                    style: TextStyle(
                      fontWeight: .bold,
                      color: isDarkMode ? Colors.white : Colors.black54,
                    ), // Corregido .bold
                  ),
                ),

                // Barra de Progreso Visual Eficiente
                Expanded(
                  // Es mejor usar el widget Expanded directamente rodeando al ClipRRect en vez de la extensión .expanded para evitar problemas de maquetación en Rows nativos
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: statSlot.baseStat / 255,
                      backgroundColor: Colors.grey.shade100,
                      // Cambiamos el helper privado por tu nueva extensión int intuitiva
                      valueColor: AlwaysStoppedAnimation<Color>(
                        statSlot.baseStat.toPokemonStatColor,
                      ),
                      minHeight: 8,
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

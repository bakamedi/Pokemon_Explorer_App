import 'package:flutter/material.dart';
import 'package:poke_test/domain/models/pokemon_detail_model.dart';
import 'package:poke_test/presentation/globals/extensions/pokemon_int_ext.dart';
import 'package:poke_test/presentation/globals/extensions/pokemon_string_ext.dart'; // Tu ruta real del modelo

class PokemonBaseStatsW extends StatelessWidget {
  const PokemonBaseStatsW({super.key, required this.stats});

  // Pasamos únicamente la lista de stats para mantener el componente desacoplado
  final List<StatSlot> stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16), // Corregido .all
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // Corregido .circular
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
            padding: const EdgeInsets.symmetric(vertical: 6.0), // Corregido .symmetric
            child: Row(
              children: [
                // Nombre abreviado del Stat (ej: ATK, DEF) utilizando tu extensión
                SizedBox(
                  width: 80,
                  child: Text(
                    statSlot.stat.name.abbreviatePokemonStat,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600, // Corregido .w600
                      color: Colors.black54,
                    ),
                  ),
                ),
                
                // Valor Numérico Base del Stat
                SizedBox(
                  width: 35,
                  child: Text(
                    '${statSlot.baseStat}',
                    style: const TextStyle(fontWeight: FontWeight.bold), // Corregido .bold
                  ),
                ),
                
                // Barra de Progreso Visual Eficiente
                Expanded( // Es mejor usar el widget Expanded directamente rodeando al ClipRRect en vez de la extensión .expanded para evitar problemas de maquetación en Rows nativos
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: statSlot.baseStat / 255, // 255 es el stat máximo posible
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
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemHomeLoadingW extends StatelessWidget {
  const ItemHomeLoadingW({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      // Tonos grises suaves ideales para fondos claros
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: .circular(20), // Mismo radio que tu tarjeta real
        ),
        padding: const .all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            // Esqueleto del contenedor de la imagen
            Container(
              width: .infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: .circular(16),
              ),
            ),

            const SizedBox(height: 16),

            // Esqueleto de la línea de texto del nombre del Pokémon
            Container(
              width: 100,
              height: 15,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: .circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

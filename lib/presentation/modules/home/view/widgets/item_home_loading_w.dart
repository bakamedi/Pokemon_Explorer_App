import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';
import 'package:flutter_meedu/provider/filters.dart';
import 'package:poke_test/presentation/globals/controllers/settings/settings_gc.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:shimmer/shimmer.dart';

class ItemHomeLoadingW extends StatelessWidget {
  const ItemHomeLoadingW({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, _) {
        final isDarkMode = ref.select(settingsGP.select((s) => s.isDarkMode));

        final baseColor = isDarkMode
            ? Colors.grey.shade800
            : Colors.grey.shade300;

        final highlightColor = isDarkMode
            ? Colors.grey.shade700
            : Colors.grey.shade100;

        final skeletonColor = isDarkMode ? Colors.grey.shade900 : Colors.white;

        return Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            decoration: BoxDecoration(
              color: skeletonColor,
              borderRadius: .circular(20),
            ),
            padding: const .all(12),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                // Esqueleto del contenedor de la imagen
                Container(
                  width: .infinity,
                  height: 100.rh,
                  decoration: BoxDecoration(
                    color: skeletonColor,
                    borderRadius: .circular(16),
                  ),
                ),

                10.h,

                Container(
                  width: 100.rw,
                  height: 15.rh,
                  decoration: BoxDecoration(
                    color: skeletonColor,
                    borderRadius: .circular(4),
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

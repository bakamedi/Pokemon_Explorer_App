import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';
import 'package:flutter_meedu/provider/filters.dart';
import 'package:poke_test/presentation/globals/controllers/settings/settings_gc.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class HomeLoadingBodyW extends StatelessWidget {
  const HomeLoadingBodyW({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) {
        final isDarkMode = ref.select(settingsGP.select((s) => s.isDarkMode));

        final cardColor = isDarkMode ? AppColors.darkBackground : Colors.white;

        final shadowColor = isDarkMode
            ? Colors.black.withValues(alpha: 0.3)
            : Colors.black.withValues(alpha: 0.05);

        final baseColor = isDarkMode
            ? Colors.grey.shade800
            : Colors.grey.shade300;

        final highlightColor = isDarkMode
            ? Colors.grey.shade700
            : Colors.grey.shade100;

        final skeletonColor = isDarkMode ? Colors.grey.shade900 : Colors.white;

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.9,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: .circular(20),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const .all(16),
              child: Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highlightColor,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Container(
                      width: .infinity,
                      decoration: BoxDecoration(
                        color: skeletonColor,
                        borderRadius: .circular(16),
                      ),
                    ).expanded,
                    16.h,

                    // Esqueleto del Texto
                    Container(
                      width: 110.rw,
                      height: 16.rh,
                      decoration: BoxDecoration(
                        color: skeletonColor,
                        borderRadius: .circular(6),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

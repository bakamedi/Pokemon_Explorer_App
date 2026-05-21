import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer/consumer_widget.dart';
import 'package:flutter_meedu/provider/filters.dart';
import 'package:poke_test/presentation/globals/controllers/settings/settings_gc.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImageGW extends StatelessWidget {
  const ShimmerImageGW({super.key});

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
        final containerColor = isDarkMode ? Colors.grey.shade900 : Colors.white;
        return Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            width: .infinity,
            height: .infinity,
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: .circular(16),
            ),
          ),
        );
      },
    );
  }
}

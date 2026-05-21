import 'package:flutter/material.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:shimmer/shimmer.dart';

class HomeLoadingBodyW extends StatelessWidget {
  const HomeLoadingBodyW({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        // Desactivamos el scroll para evitar saltos raros mientras carga
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
              color: Colors.white,
              borderRadius: .circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const .all(16),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: .circular(16),
                    ),
                  ).expanded,

                  16.h,

                  Container(
                    width: 110.rw,
                    height: 16.rh,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: .circular(6),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

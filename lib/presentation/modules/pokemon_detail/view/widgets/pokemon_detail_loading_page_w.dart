import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';
import 'package:flutter_meedu/provider/filters.dart';
import 'package:poke_test/presentation/globals/controllers/settings/settings_gc.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class PokemonDetailLoadingPageW extends StatelessWidget {
  const PokemonDetailLoadingPageW({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, _) {
        final isDarkMode = ref.select(settingsGP.select((s) => s.isDarkMode));

        final scaffoldBg = isDarkMode
            ? AppColors.darkBackground
            : Colors.grey.shade50;
        final appBarBg = isDarkMode ? AppColors.darkBackground : Colors.white;
        final iconColor = isDarkMode ? Colors.white70 : Colors.black;

        final baseColor = isDarkMode
            ? Colors.grey.shade800
            : Colors.grey.shade300;
        final highlightColor = isDarkMode
            ? Colors.grey.shade700
            : Colors.grey.shade100;
        final skeletonColor = isDarkMode ? Colors.grey.shade900 : Colors.white;

        return Scaffold(
          backgroundColor: scaffoldBg,
          appBar: AppBar(
            backgroundColor: appBarBg,
            elevation: 0,
            leading: Icon(Icons.arrow_back_ios_new, color: iconColor),
            centerTitle: true,
            title: Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Container(
                width: 160.rw,
                height: 18.rh,
                decoration: BoxDecoration(
                  color: skeletonColor,
                  borderRadius: .circular(4),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const .all(20),
            child: Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Center(
                    child: Container(
                      width: .infinity,
                      height: 200.rh,
                      decoration: BoxDecoration(
                        color: skeletonColor,
                        borderRadius: .circular(24),
                      ),
                    ),
                  ),
                  24.h,

                  Row(
                    children: [
                      Container(
                        width: 85.rw,
                        height: 32.rh,
                        decoration: BoxDecoration(
                          color: skeletonColor,
                          borderRadius: .circular(12),
                        ),
                      ),
                      8.w,
                      Container(
                        width: 85.rw,
                        height: 32.rh,
                        decoration: BoxDecoration(
                          color: skeletonColor,
                          borderRadius: .circular(12),
                        ),
                      ),
                    ],
                  ),
                  24.h,

                  Row(
                    children: [
                      Container(
                        height: 72.rh,
                        decoration: BoxDecoration(
                          color: skeletonColor,
                          borderRadius: .circular(16),
                        ),
                      ).expanded,
                      16.w,
                      Container(
                        height: 72.rh,
                        decoration: BoxDecoration(
                          color: skeletonColor,
                          borderRadius: .circular(16),
                        ),
                      ).expanded,
                    ],
                  ),
                  24.h,

                  Container(
                    width: 90.rw,
                    height: 14.rh,
                    decoration: BoxDecoration(
                      color: skeletonColor,
                      borderRadius: .circular(4),
                    ),
                  ),
                  12.h,
                  Row(
                    children: [
                      Container(
                        width: 110.rw,
                        height: 36.rh,
                        decoration: BoxDecoration(
                          color: skeletonColor,
                          borderRadius: .circular(10),
                        ),
                      ),
                      8.h,
                      Container(
                        width: 125.rw,
                        height: 36.rh,
                        decoration: BoxDecoration(
                          color: skeletonColor,
                          borderRadius: .circular(10),
                        ),
                      ),
                    ],
                  ),
                  24.h,

                  Container(
                    width: 100.rw,
                    height: 14.rh,
                    decoration: BoxDecoration(
                      color: skeletonColor,
                      borderRadius: .circular(4),
                    ),
                  ),
                  12.h,

                  Container(
                    padding: const .all(16),
                    decoration: BoxDecoration(
                      color: skeletonColor,
                      borderRadius: .circular(16),
                    ),
                    child: Column(
                      children: .generate(6, (index) {
                        return Padding(
                          padding: const .symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              // Nombre del stat
                              Container(
                                width: 45.rw,
                                height: 14.rh,
                                decoration: BoxDecoration(
                                  color: skeletonColor,
                                  borderRadius: .circular(4),
                                ),
                              ),
                              24.w,
                              Container(
                                width: 25.rw,
                                height: 14.rh,
                                decoration: BoxDecoration(
                                  color: skeletonColor,
                                  borderRadius: .circular(4),
                                ),
                              ),
                              16.w,
                              Container(
                                height: 8.rh,
                                decoration: BoxDecoration(
                                  color: skeletonColor,
                                  borderRadius: .circular(4),
                                ),
                              ).expanded,
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

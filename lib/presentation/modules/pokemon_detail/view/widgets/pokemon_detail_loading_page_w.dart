import 'package:flutter/material.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:shimmer/shimmer.dart';

class PokemonDetailLoadingPageW extends StatelessWidget {
  const PokemonDetailLoadingPageW({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        centerTitle: true,
        title: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 160.rw,
            height: 18.rh,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: .circular(4),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const .all(20),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Center(
                child: Container(
                  width: .infinity,
                  height: 200.rh,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                      color: Colors.white,
                      borderRadius: .circular(12),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 85.rw,
                    height: 32.rh,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                      color: Colors.white,
                      borderRadius: .circular(16),
                    ),
                  ).expanded,
                  16.w,
                  Container(
                    height: 72.rh,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                  color: Colors.white,
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
                      color: Colors.white,
                      borderRadius: .circular(10),
                    ),
                  ),
                  8.h,
                  Container(
                    width: 125.rw,
                    height: 36.rh,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                  color: Colors.white,
                  borderRadius: .circular(4),
                ),
              ),
              12.h,

              Container(
                padding: const .all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: .circular(16),
                ),
                child: Column(
                  children: .generate(6, (index) {
                    return Padding(
                      padding: const .symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 45.rw,
                            height: 14.rh,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: .circular(4),
                            ),
                          ),
                          24.w,
                          // Valor numérico base
                          Container(
                            width: 25.rw,
                            height: 14.rh,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: .circular(4),
                            ),
                          ),
                          16.w,
                          Container(
                            height: 8.rh,
                            decoration: BoxDecoration(
                              color: Colors.white,
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
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImageGW extends StatelessWidget {
  const ShimmerImageGW({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: .infinity,
        height: .infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: .circular(16),
        ),
      ),
    );
  }
}

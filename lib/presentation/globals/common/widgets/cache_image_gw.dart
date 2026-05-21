import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:poke_test/presentation/globals/common/widgets/shimmer_image_gw.dart';

class CacheImageGW extends StatelessWidget {
  const CacheImageGW({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.fit,
  });

  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      cache: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case .loading:
            return ShimmerImageGW();

          case .failed:
            return const Icon(Icons.broken_image, color: Colors.grey);

          case .completed:
            return null;
        }
      },
    );
  }
}

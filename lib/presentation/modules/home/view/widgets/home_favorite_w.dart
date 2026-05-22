import 'package:flutter/material.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';

class HomeFavoriteW extends StatelessWidget {
  const HomeFavoriteW({
    super.key,
    required this.isFavorite,
    required this.isDarkMode,
    required this.onTap,
  });

  final bool isFavorite;
  final bool isDarkMode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8.rh,
      left: 8.rw,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const .all(6),
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.white.withValues(alpha: 0.7),
            shape: .circle,
          ),
          child: Icon(
            isFavorite ? Icons.star : Icons.star_border,
            color: isFavorite
                ? Colors.amber
                : (isDarkMode ? Colors.white70 : Colors.black45),
            size: 18.sp,
          ),
        ),
      ),
    );
  }
}

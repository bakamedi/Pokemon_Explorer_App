import 'dart:math' as math;
import 'package:flutter/material.dart';

class ResponsiveScreen {
  ResponsiveScreen(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    width = size.width;
    height = size.height;

    diagonal = math.sqrt(width * width + height * height);

    _scaleWidth = width / _designWidth;
    _scaleHeight = height / _designHeight;
    _scaleText = math.min(_scaleWidth, _scaleHeight);
  }

  /// base design size (Figma)
  static const double _designWidth = 402;
  static const double _designHeight = 874;

  late final double width;
  late final double height;
  late final double diagonal;

  late final double _scaleWidth;
  late final double _scaleHeight;
  late final double _scaleText;

  /// responsive width
  double rw(double size) {
    return size * _scaleWidth;
  }

  /// responsive height
  double rh(double size) {
    return size * _scaleHeight;
  }

  /// responsive font
  double rsp(double size) {
    return size * _scaleText.clamp(0.85, 1.25);
  }

  /// responsive diagonal
  double rdg(double size) {
    return size *
        (diagonal /
            math.sqrt(
              _designWidth * _designWidth + _designHeight * _designHeight,
            ));
  }
}

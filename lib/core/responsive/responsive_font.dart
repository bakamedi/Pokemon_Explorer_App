import 'package:flutter/material.dart';

import '../device_types/device_type_ext.dart';

class ResponsiveFont {
  static double scale(BuildContext context, double size) {
    final device = context.device.deviceType;

    switch (device) {
      case .phone:
        return size;

      case .tablet:
        return size * 1.2;

      case .desktop:
        return size * 1.35;
    }
  }
}

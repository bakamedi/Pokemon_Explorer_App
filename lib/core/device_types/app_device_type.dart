import 'package:flutter/material.dart';

import 'device_type.dart';

class AppDeviceType {
  AppDeviceType(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    _width = size.width;
    _height = size.height;
  }

  late final double _width;
  late final double _height;

  DeviceType get deviceType {
    if (_width < DeviceType.phone.value) {
      return .phone;
    } else if (_width < DeviceType.tablet.value) {
      return .tablet;
    }
    return .desktop;
  }

  bool get isPhone => deviceType == .phone;
  bool get isTablet => deviceType == .tablet;
  bool get isDesktop => deviceType == .desktop;

  bool get isLandscape => _width > _height;

  double get width => _width;
  double get height => _height;
}

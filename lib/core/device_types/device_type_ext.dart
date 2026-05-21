import 'package:flutter/material.dart';

import 'app_device_type.dart';

extension DeviceTypeExt on BuildContext {
  AppDeviceType get device => .new(this);
}

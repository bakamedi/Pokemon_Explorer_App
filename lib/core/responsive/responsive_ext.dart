import 'package:flutter/material.dart';

import 'responsive_screen.dart';

extension ResponsiveExt on BuildContext {
  ResponsiveScreen get rs => .new(this);
}

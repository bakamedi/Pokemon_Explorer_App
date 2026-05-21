import 'package:flutter/material.dart';
import 'package:poke_test/core/responsive/responsive_screen.dart';

import '../controllers/navigator_key/navigator_key_gc.dart';

class AppAdaptiveScreenUtil {
  static BuildContext get _context {
    final context = navigatorKeyGC.read().state.navigatorKey?.currentContext;
    if (context == null) {
      throw FlutterError(
        'AppAdaptiveScreenUtil: navigatorKey.currentContext is null. '
        'This typically happens when AppAdaptiveScreenUtil is used before the '
        'MaterialApp is fully built and the navigatorKey is attached.',
      );
    }
    return context;
  }

  static ResponsiveScreen get _screen => ResponsiveScreen(_context);

  static double rw(double px) => _screen.rw(px);

  static double rh(double px) => _screen.rh(px);

  static double rsp(double px) => _screen.rsp(px);

  static double rdg(double px) => _screen.rdg(px);
}
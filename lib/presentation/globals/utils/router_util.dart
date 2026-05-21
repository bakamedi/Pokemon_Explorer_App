// lib/core/utils/navigation_utils.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_test/routes/app_pages.dart';

abstract class RouterUtil {
  static GoRouter get _router => AppRouter.routerProvider.read();

  static BuildContext get context => AppRouter.navigatorKey.currentContext!;

  static void push(String route, {Object? extra}) {
    _router.push(route, extra: extra);
  }

  static void pushReplacement(String route, {Object? extra}) {
    _router.pushReplacement(route, extra: extra);
  }

  static void go(String route, {Object? extra}) {
    _router.go(route, extra: extra);
  }

  static void pop() {
    _router.pop();
  }
}

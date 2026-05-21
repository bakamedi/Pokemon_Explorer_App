import 'package:flutter/material.dart';
import 'package:flutter_meedu/providers.dart';

import 'package:go_router/go_router.dart';
import 'package:poke_test/presentation/globals/controllers/navigator_key/navigator_key_gc.dart';
import 'package:poke_test/routes/app_routes.dart/home_route.dart';
import 'package:poke_test/routes/app_routes.dart/login_route.dart';
import 'package:poke_test/routes/app_routes.dart/pokemon_detail.dart';
import 'package:poke_test/routes/app_routes.dart/splash_route.dart';


class AppRouter {
  static GlobalKey<NavigatorState> get navigatorKey =>
      navigatorKeyGC.read().state.navigatorKey!;

  static final routerProvider = Provider(
    (ref) => GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: SplashRoute.path,
      routes: [
        HomeRoute.route,
        SplashRoute.route,
        LoginRoute.route,
        PokemonDetailRoute.route,
      ],
    ),
  );
}

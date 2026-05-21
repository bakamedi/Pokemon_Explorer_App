import 'package:flutter_meedu/providers.dart';
import 'package:flutter_meedu/notifiers.dart';
import 'package:poke_test/routes/app_routes.dart/login_route.dart';
import 'splash_state.dart';

final splashProvider = Provider.state<SplashController, SplashState>(
  (_) => SplashController(SplashState.initialState),
);

class SplashController extends StateNotifier<SplashState> {
  SplashController(super.initialState) {
    _init();
  }

  void _init() async {
    Future.delayed(const Duration(seconds: 2), () {
      onlyUpdate(state = state.copyWith(routeName: LoginRoute.path));
    });
  }
}

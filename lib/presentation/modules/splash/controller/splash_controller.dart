import 'package:flutter_meedu/providers.dart';
import 'package:flutter_meedu/notifiers.dart';
import 'package:poke_test/data/injects/repositories/app_inject_repositories.dart';
import 'package:poke_test/domain/repositories/index_repositories.dart';
import 'package:poke_test/routes/app_routes.dart/home_route.dart';
import 'package:poke_test/routes/app_routes.dart/login_route.dart';
import 'splash_state.dart';

final splashProvider = Provider.state<SplashController, SplashState>(
  (_) => SplashController(
    SplashState.initialState,
    deviceRepository: AppInjectRepositories.deviceRep.read(),
  ),
);

class SplashController extends StateNotifier<SplashState> {
  SplashController(super.initialState, {required this._deviceRepository}) {
    _init();
  }

  final DeviceRepository _deviceRepository;

  void _init() async {
    final responses = await Future.wait([
      _deviceRepository.readString(key: 'device_token'),
      Future.delayed(const Duration(seconds: 2)),
    ]);
    final result = responses.first;
    final nextRoute = (result == null) ? LoginRoute.path : HomeRoute.path;
    onlyUpdate(state = state.copyWith(routeName: nextRoute));
  }
}

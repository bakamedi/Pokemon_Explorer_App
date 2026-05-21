import 'package:go_router/go_router.dart';
import 'package:poke_test/presentation/modules/splash/splash_page.dart';

class SplashRoute {
  static const path = '/splash';

  static GoRoute get route {
    return GoRoute(path: path, builder: (_, _) => const SplashPage());
  }
}

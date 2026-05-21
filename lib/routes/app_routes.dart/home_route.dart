import 'package:go_router/go_router.dart';
import 'package:poke_test/presentation/home/view/home_page.dart';


class HomeRoute {
  static const path = '/home';

  static GoRoute get route {
    return GoRoute(
      path: path,
      builder: (_, _) =>  HomePage()
    );
  }
}

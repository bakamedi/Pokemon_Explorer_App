import 'package:go_router/go_router.dart';
import 'package:poke_test/presentation/login/login_page.dart';


class LoginRoute {
  static const path = '/login';

  static GoRoute get route {
    return GoRoute(
      path: path,
      builder: (_, _) =>  LoginPage()
    );
  }
}

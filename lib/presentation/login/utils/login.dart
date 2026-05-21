import 'package:poke_test/presentation/globals/extensions/failure_bottom_sheet_ext.dart';
import 'package:poke_test/presentation/globals/utils/loader_util.dart';
import 'package:poke_test/presentation/globals/utils/router_util.dart';
import 'package:poke_test/presentation/login/controller/login_controller.dart';
import 'package:poke_test/routes/app_routes.dart/home_route.dart';

void login() async {
  LoaderUtil.show();
  final loginController = loginProvider.read();
  final result = await loginController.sendLogin();
  LoaderUtil.hide();

  result.fold((failure) => failure.showBottomSheet(), (_) {
    RouterUtil.pushReplacement(HomeRoute.path);
  });
}

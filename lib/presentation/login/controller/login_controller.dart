import 'package:flutter_meedu/providers.dart';
import 'package:flutter_meedu/notifiers.dart';
import 'package:poke_test/data/injects/repositories/app_inject_repositories.dart';
import 'package:poke_test/domain/models/eighter/typedefs.dart';
import 'package:poke_test/domain/models/failures/failure.dart';
import 'package:poke_test/domain/repositories/auth/auth_repository.dart';
import 'package:poke_test/presentation/login/controller/login_state.dart';

final loginProvider = Provider.state<LoginController, LoginState>(
  (_) => LoginController(
    LoginState.initialState,
    authRepository: AppInjectRepositories.authRep.read(),
  ),
);

class LoginController extends StateNotifier<LoginState> {
  LoginController(super.initialState, {required this._authRepository});

  final AuthRepository _authRepository;

  bool get isValid =>
      state.username.trim().isNotEmpty && state.password.trim().isNotEmpty;

  void onChangeUsername(String? value) {
    onlyUpdate(state = state.copyWith(username: value ?? ''));
  }

  void onChangePassword(String? value) {
    onlyUpdate(state = state.copyWith(password: value ?? ''));
  }

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  FutureEither<Failure, void> sendLogin() async {
    return await _authRepository.login(state.username, state.password);
  }
}

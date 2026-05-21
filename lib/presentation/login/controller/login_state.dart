import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const LoginState._();
  const factory LoginState({
    @Default('') String username,
    @Default('') String password,
    @Default(true) bool obscurePassword,
  }) = _LoginState;

  static LoginState get initialState =>
      const LoginState(username: '', password: '', obscurePassword: true);
}

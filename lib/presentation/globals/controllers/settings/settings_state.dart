import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const SettingsState._();

  const factory SettingsState({@Default(false) bool isDarkMode}) =
      _SettingsState;

  static SettingsState get initialState => SettingsState(isDarkMode: false);
}

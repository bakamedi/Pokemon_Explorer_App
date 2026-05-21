import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigator_key_state.freezed.dart';

@freezed
abstract class NavigatorKeyState with _$NavigatorKeyState {
  const NavigatorKeyState._();

  const factory NavigatorKeyState({GlobalKey<NavigatorState>? navigatorKey}) =
      _NavigatorKeyState;

  static NavigatorKeyState get initialState =>
      NavigatorKeyState(navigatorKey: GlobalKey<NavigatorState>());
}

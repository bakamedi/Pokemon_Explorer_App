import 'package:flutter_meedu/notifiers.dart';
import 'package:flutter_meedu/providers.dart';

import 'navigator_key_state.dart';

final navigatorKeyGC = Provider.state<NavigatorKeyGC, NavigatorKeyState>(
  (_) => NavigatorKeyGC(NavigatorKeyState.initialState),
  autoDispose: false,
);

class NavigatorKeyGC extends StateNotifier<NavigatorKeyState> {
  NavigatorKeyGC(super.initialState);
}

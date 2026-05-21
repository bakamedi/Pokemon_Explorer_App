import 'package:flutter_meedu/notifiers.dart';
import 'package:flutter_meedu/providers.dart';

import 'loader_state.dart';

final loaderGlobalProvider = Provider.state<LoaderGC, LoaderState>(
  (_) => LoaderGC(LoaderState.initialState),
);

class LoaderGC extends StateNotifier<LoaderState> {
  LoaderGC(super.initialState);

  bool get loading => state.loading;

  Future<void> showLoader({required bool loading}) async {
    onlyUpdate(state = state.copyWith(loading: loading));
  }
}

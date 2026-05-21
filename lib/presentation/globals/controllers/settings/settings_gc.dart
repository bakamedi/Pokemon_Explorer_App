import 'package:flutter/material.dart';
import 'package:flutter_meedu/notifiers.dart';
import 'package:flutter_meedu/providers.dart';
import 'package:poke_test/data/injects/repositories/app_inject_repositories.dart';
import 'package:poke_test/domain/repositories/device/device_repository.dart';

import 'settings_state.dart';

final settingsGP = Provider.state<SettingsGC, SettingsState>(
  (_) => SettingsGC(
    SettingsState.initialState,
    deviceRepository: AppInjectRepositories.deviceRep.read(),
  ),
  autoDispose: false,
);

class SettingsGC extends StateNotifier<SettingsState> {
  SettingsGC(super.initialState, {required this._deviceRepository});

  final DeviceRepository _deviceRepository;

  void onInit(BuildContext context) async {
    final theme = Theme.of(context);
    final isDark = theme.brightness == .dark;

    state = state.copyWith(isDarkMode: isDark);
    await _deviceRepository.writeBool(key: 'is_dark_mode', value: isDark);
  }

  void toggleDarkMode() async {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
    await _deviceRepository.writeBool(
      key: 'is_dark_mode',
      value: state.isDarkMode,
    );
  }
}

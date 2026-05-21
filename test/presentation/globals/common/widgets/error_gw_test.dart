import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_test/presentation/globals/common/widgets/error_gw.dart';
import 'package:poke_test/presentation/globals/controllers/settings/settings_gc.dart';
import 'package:poke_test/presentation/globals/controllers/settings/settings_state.dart';
import 'package:poke_test/presentation/globals/controllers/navigator_key/navigator_key_gc.dart';
import 'package:poke_test/domain/repositories/device/device_repository.dart';

import 'package:flutter_meedu/providers.dart';

class MockDeviceRepository extends Mock implements DeviceRepository {}

void main() {
  late MockDeviceRepository mockDeviceRepository;

  setUp(() {
    ProvidersContainer.clear();
    mockDeviceRepository = MockDeviceRepository();
  });

  void setupSettings({required bool isDarkMode}) {
    settingsGP.overrideCreator((_) => SettingsGC(
          SettingsState.initialState.copyWith(isDarkMode: isDarkMode),
          deviceRepository: mockDeviceRepository,
        ));
  }

  testWidgets('ErrorGW renders correctly in light mode', (WidgetTester tester) async {
    setupSettings(isDarkMode: false);
    final navKey = navigatorKeyGC.read().state.navigatorKey!;
    
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        home: const Scaffold(
          body: ErrorGW(),
        ),
      ),
    );

    expect(find.text('Sin conexión a internet'), findsOneWidget);
    expect(find.byIcon(Icons.error_outline), findsOneWidget);
    
    final Icon iconWidget = tester.widget(find.byIcon(Icons.error_outline));
    expect(iconWidget.color, Colors.grey.shade600);
  });

  testWidgets('ErrorGW renders correctly in dark mode', (WidgetTester tester) async {
    setupSettings(isDarkMode: true);
    final navKey = navigatorKeyGC.read().state.navigatorKey!;
    
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        home: const Scaffold(
          body: ErrorGW(),
        ),
      ),
    );

    expect(find.text('Sin conexión a internet'), findsOneWidget);
    expect(find.byIcon(Icons.error_outline), findsOneWidget);
    
    final Icon iconWidget = tester.widget(find.byIcon(Icons.error_outline));
    expect(iconWidget.color, isNot(Colors.grey.shade600));
  });
}

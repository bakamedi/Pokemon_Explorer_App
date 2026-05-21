import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_meedu/providers.dart';
import 'package:shimmer/shimmer.dart';
import 'package:poke_test/presentation/globals/common/widgets/shimmer_image_gw.dart';
import 'package:poke_test/presentation/globals/controllers/settings/settings_gc.dart';
import 'package:poke_test/presentation/globals/controllers/settings/settings_state.dart';
import 'package:poke_test/presentation/globals/controllers/navigator_key/navigator_key_gc.dart';
import 'package:poke_test/domain/repositories/device/device_repository.dart';

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

  testWidgets('ShimmerImageGW renders correctly in light mode', (WidgetTester tester) async {
    setupSettings(isDarkMode: false);
    final navKey = navigatorKeyGC.read().state.navigatorKey!;

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        home: const Scaffold(
          body: ShimmerImageGW(),
        ),
      ),
    );

    expect(find.byType(Shimmer), findsOneWidget);
    final Shimmer shimmer = tester.widget(find.byType(Shimmer));
    expect(shimmer.gradient, isA<LinearGradient>());
    final gradient = shimmer.gradient as LinearGradient;
    expect(gradient.colors[0], Colors.grey.shade300);
    expect(gradient.colors[2], Colors.grey.shade100);
  });

  testWidgets('ShimmerImageGW renders correctly in dark mode', (WidgetTester tester) async {
    setupSettings(isDarkMode: true);
    final navKey = navigatorKeyGC.read().state.navigatorKey!;

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        home: const Scaffold(
          body: ShimmerImageGW(),
        ),
      ),
    );

    expect(find.byType(Shimmer), findsOneWidget);
    final Shimmer shimmer = tester.widget(find.byType(Shimmer));
    expect(shimmer.gradient, isA<LinearGradient>());
    final gradient = shimmer.gradient as LinearGradient;
    expect(gradient.colors[0], Colors.grey.shade800);
    expect(gradient.colors[2], Colors.grey.shade700);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:extended_image/extended_image.dart';
import 'package:poke_test/presentation/globals/common/widgets/cache_image_gw.dart';
import 'package:poke_test/presentation/globals/controllers/settings/settings_gc.dart';
import 'package:poke_test/presentation/globals/controllers/settings/settings_state.dart';
import 'package:poke_test/presentation/globals/controllers/navigator_key/navigator_key_gc.dart';
import 'package:poke_test/domain/repositories/device/device_repository.dart';

class MockDeviceRepository extends Mock implements DeviceRepository {}

void main() {
  late MockDeviceRepository mockDeviceRepository;

  setUp(() {
    mockDeviceRepository = MockDeviceRepository();
    settingsGP.overrideCreator((_) => SettingsGC(
          SettingsState.initialState,
          deviceRepository: mockDeviceRepository,
        ));
  });

  testWidgets('CacheImageGW renders ExtendedImage network', (WidgetTester tester) async {
    final navKey = navigatorKeyGC.read().state.navigatorKey!;
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        home: const Scaffold(
          body: CacheImageGW(
            imageUrl: 'https://example.com/poke.png',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    // Verify ExtendedImage is present
    expect(find.byType(ExtendedImage), findsOneWidget);
  });
}

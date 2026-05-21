import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_test/domain/repositories/device/device_repository.dart';
import 'package:poke_test/presentation/globals/controllers/settings/settings_gc.dart';
import 'package:poke_test/presentation/globals/controllers/settings/settings_state.dart';

class MockDeviceRepository extends Mock implements DeviceRepository {}

void main() {
  late SettingsGC settingsGC;
  late MockDeviceRepository mockDeviceRepository;

  setUp(() {
    mockDeviceRepository = MockDeviceRepository();
    settingsGC = SettingsGC(
      SettingsState.initialState,
      deviceRepository: mockDeviceRepository,
    );
  });

  group('SettingsGC', () {
    test('toggleDarkMode should change state and write to repository', () async {
      // Arrange
      final initialState = settingsGC.state.isDarkMode;
      when(() => mockDeviceRepository.writeBool(
            key: any(named: 'key'),
            value: any(named: 'value'),
          )).thenAnswer((_) async => true);

      // Act
      settingsGC.toggleDarkMode();

      // Assert
      expect(settingsGC.state.isDarkMode, !initialState);
      verify(() => mockDeviceRepository.writeBool(
            key: 'is_dark_mode',
            value: !initialState,
          )).called(1);
    });
  });
}

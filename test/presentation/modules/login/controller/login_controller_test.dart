import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_test/domain/models/eighter/either.dart';
import 'package:poke_test/domain/repositories/auth/auth_repository.dart';
import 'package:poke_test/domain/repositories/device/device_repository.dart';
import 'package:poke_test/presentation/modules/login/controller/login_controller.dart';
import 'package:poke_test/presentation/modules/login/controller/login_state.dart';

class MockAuthRepository extends Mock implements AuthRepository {}
class MockDeviceRepository extends Mock implements DeviceRepository {}

void main() {
  late LoginController loginController;
  late MockAuthRepository mockAuthRepository;
  late MockDeviceRepository mockDeviceRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockDeviceRepository = MockDeviceRepository();
    loginController = LoginController(
      LoginState.initialState,
      authRepository: mockAuthRepository,
      deviceRepository: mockDeviceRepository,
    );
  });

  group('LoginController - Validation', () {
    test('isValid should return false if fields are empty', () {
      expect(loginController.isValid, false);
    });

    test('isValid should return true if fields are not empty', () {
      loginController.onChangeUsername('test');
      loginController.onChangePassword('password');
      expect(loginController.isValid, true);
    });
  });

  group('LoginController - Actions', () {
    test('togglePasswordVisibility should change obscurePassword state', () {
      final initial = loginController.state.obscurePassword;
      loginController.togglePasswordVisibility();
      expect(loginController.state.obscurePassword, !initial);
    });

    test('sendLogin should call authRepository', () async {
      // Arrange
      when(() => mockAuthRepository.login(any(), any()))
          .thenAnswer((_) async => Either.right(null));

      // Act
      await loginController.sendLogin();

      // Assert
      verify(() => mockAuthRepository.login(any(), any())).called(1);
    });

    test('saveDeviceToken should call deviceRepository', () async {
      // Arrange
      when(() => mockDeviceRepository.writeString(
            key: any(named: 'key'),
            value: any(named: 'value'),
          )).thenAnswer((_) async => true);

      // Act
      await loginController.saveDeviceToken('token');

      // Assert
      verify(() => mockDeviceRepository.writeString(
            key: 'device_token',
            value: 'token',
          )).called(1);
    });
  });
}

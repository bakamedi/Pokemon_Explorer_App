import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_test/domain/repositories/index_repositories.dart';
import 'package:poke_test/presentation/modules/splash/controller/splash_controller.dart';
import 'package:poke_test/presentation/modules/splash/controller/splash_state.dart';
import 'package:poke_test/routes/app_routes.dart/home_route.dart';
import 'package:poke_test/routes/app_routes.dart/login_route.dart';

class MockDeviceRepository extends Mock implements DeviceRepository {}

void main() {
  late MockDeviceRepository mockDeviceRepository;

  setUp(() {
    mockDeviceRepository = MockDeviceRepository();
  });

  test('SplashController - Should navigate to HomeRoute if token exists', () async {
    // Arrange
    when(() => mockDeviceRepository.readString(key: 'device_token'))
        .thenAnswer((_) async => 'some_token');

    // Act
    final controller = SplashController(
      SplashState.initialState,
      deviceRepository: mockDeviceRepository,
    );
    
    // Wait for the async _init to complete
    await Future.delayed(const Duration(seconds: 3));

    // Assert
    expect(controller.state.routeName, HomeRoute.path);
  });

  test('SplashController - Should navigate to LoginRoute if token is null', () async {
    // Arrange
    when(() => mockDeviceRepository.readString(key: 'device_token'))
        .thenAnswer((_) async => null);

    // Act
    final controller = SplashController(
      SplashState.initialState,
      deviceRepository: mockDeviceRepository,
    );

    // Wait for the async _init to complete
    await Future.delayed(const Duration(seconds: 3));

    // Assert
    expect(controller.state.routeName, LoginRoute.path);
  });
}

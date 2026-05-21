import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_test/presentation/globals/common/widgets/app_state_wrapper_gw.dart';
import 'package:poke_test/presentation/globals/utils/app_view_state_util.dart';
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
    // Override settingsGP so it does not fail when build looks for it
    settingsGP.overrideCreator((_) => SettingsGC(
          SettingsState.initialState,
          deviceRepository: mockDeviceRepository,
        ));
  });

  testWidgets('AppStateWrapperGW - loading state renders loading widget', (WidgetTester tester) async {
    final navKey = navigatorKeyGC.read().state.navigatorKey!;
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        home: AppStateWrapperGW(
          appViewStateUtil: AppViewStateUtil.loading,
          onSuccess: (_) => const Text('Success'),
          loadingWidget: const Text('Loading Custom'),
        ),
      ),
    );

    expect(find.text('Loading Custom'), findsOneWidget);
    expect(find.text('Success'), findsNothing);
  });

  testWidgets('AppStateWrapperGW - loading state renders default adaptive indicator', (WidgetTester tester) async {
    final navKey = navigatorKeyGC.read().state.navigatorKey!;
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        home: AppStateWrapperGW(
          appViewStateUtil: AppViewStateUtil.loading,
          onSuccess: (_) => const Text('Success'),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('AppStateWrapperGW - error state renders custom error widget', (WidgetTester tester) async {
    final navKey = navigatorKeyGC.read().state.navigatorKey!;
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        home: AppStateWrapperGW(
          appViewStateUtil: AppViewStateUtil.error,
          onSuccess: (_) => const Text('Success'),
          errorWidget: const Text('Error Custom'),
        ),
      ),
    );

    expect(find.text('Error Custom'), findsOneWidget);
  });

  testWidgets('AppStateWrapperGW - error state renders default ErrorGW', (WidgetTester tester) async {
    final navKey = navigatorKeyGC.read().state.navigatorKey!;
    // ErrorGW requires SettingsGP, we must mock/stub readBool of mockDeviceRepository
    when(() => mockDeviceRepository.readBool(key: any(named: 'key')))
        .thenAnswer((_) async => false);
    when(() => mockDeviceRepository.writeBool(
          key: any(named: 'key'),
          value: any(named: 'value'),
        )).thenAnswer((_) async => true);

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        home: AppStateWrapperGW(
          appViewStateUtil: AppViewStateUtil.error,
          onSuccess: (_) => const Text('Success'),
        ),
      ),
    );

    expect(find.text('Sin conexión a internet'), findsOneWidget);
  });

  testWidgets('AppStateWrapperGW - empty state renders custom empty widget', (WidgetTester tester) async {
    final navKey = navigatorKeyGC.read().state.navigatorKey!;
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        home: AppStateWrapperGW(
          appViewStateUtil: AppViewStateUtil.empty,
          onSuccess: (_) => const Text('Success'),
          emptyWidget: const Text('Empty Custom'),
        ),
      ),
    );

    expect(find.text('Empty Custom'), findsOneWidget);
  });

  testWidgets('AppStateWrapperGW - empty state renders default Text', (WidgetTester tester) async {
    final navKey = navigatorKeyGC.read().state.navigatorKey!;
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        home: AppStateWrapperGW(
          appViewStateUtil: AppViewStateUtil.empty,
          onSuccess: (_) => const Text('Success'),
        ),
      ),
    );

    expect(find.text('No hay datos'), findsOneWidget);
  });

  testWidgets('AppStateWrapperGW - success state calls onSuccess', (WidgetTester tester) async {
    final navKey = navigatorKeyGC.read().state.navigatorKey!;
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        home: AppStateWrapperGW(
          appViewStateUtil: AppViewStateUtil.success,
          onSuccess: (_) => const Text('Success Custom'),
        ),
      ),
    );

    expect(find.text('Success Custom'), findsOneWidget);
  });

  testWidgets('AppStateWrapperGW - idle state renders custom idle widget', (WidgetTester tester) async {
    final navKey = navigatorKeyGC.read().state.navigatorKey!;
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        home: AppStateWrapperGW(
          appViewStateUtil: AppViewStateUtil.idle,
          onSuccess: (_) => const Text('Success'),
          idleWidget: const Text('Idle Custom'),
        ),
      ),
    );

    expect(find.text('Idle Custom'), findsOneWidget);
  });

  testWidgets('AppStateWrapperGW - idle state renders default shrinked SizedBox', (WidgetTester tester) async {
    final navKey = navigatorKeyGC.read().state.navigatorKey!;
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        home: AppStateWrapperGW(
          appViewStateUtil: AppViewStateUtil.idle,
          onSuccess: (_) => const Text('Success'),
        ),
      ),
    );

    final sizedBoxFinder = find.byType(SizedBox);
    expect(sizedBoxFinder, findsOneWidget);
    final SizedBox sizedBox = tester.widget(sizedBoxFinder);
    expect(sizedBox.width, 0.0);
    expect(sizedBox.height, 0.0);
  });
}

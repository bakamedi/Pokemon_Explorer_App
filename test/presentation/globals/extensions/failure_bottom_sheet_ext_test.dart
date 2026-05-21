import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_meedu/providers.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_test/domain/models/failures/failure.dart';
import 'package:poke_test/presentation/globals/extensions/failure_bottom_sheet_ext.dart';
import 'package:poke_test/routes/app_pages.dart';
import 'package:poke_test/presentation/globals/controllers/navigator_key/navigator_key_gc.dart';

void main() {
  setUp(() {
    ProvidersContainer.clear();
  });

  group('FailureBottomSheetExt - title and message properties', () {
    test('returns correct title and message for network failure', () {
      const failure = Failure.network(message: 'No internet');
      expect(failure.title, 'Error de conexión');
      expect(failure.message, 'No internet');
    });

    test('returns correct title and message for unknown failure', () {
      const failure = Failure.unknown(message: 'Unknown error');
      expect(failure.title, 'Error desconocido');
      expect(failure.message, 'Unknown error');
    });

    test('returns correct title and message for api failure', () {
      const failure = Failure.api(message: 'Server error');
      expect(failure.title, 'Error del servidor');
      expect(failure.message, 'Server error');
    });

    test('returns correct title and message for auth failure', () {
      const failure = Failure.auth(message: 'Auth error');
      expect(failure.title, 'Error de autenticación');
      expect(failure.message, 'Auth error');
    });

    test('returns correct title and message for validation failure', () {
      const failure = Failure.validation(message: 'Validation error');
      expect(failure.title, 'Datos inválidos');
      expect(failure.message, 'Validation error');
    });

    test('returns correct title and message for other failures', () {
      const failure = Failure.business(message: 'Business error');
      expect(failure.title, 'Error');
      expect(failure.message, 'Business error');

      const noData = Failure.noData('No data');
      expect(noData.title, 'Sin datos');

      const timeout = Failure.timeout('Timeout');
      expect(timeout.title, 'Tiempo agotado');
    });
  });

  testWidgets('FailureBottomSheetExt showBottomSheet displays bottom sheet', (WidgetTester tester) async {
    final navKey = navigatorKeyGC.read().state.navigatorKey!;
    
    final router = GoRouter(
      navigatorKey: navKey,
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: Builder(
              builder: (ctx) {
                return ElevatedButton(
                  onPressed: () {
                    const Failure.network(message: 'Network issue').showBottomSheet();
                  },
                  child: const Text('Show Sheet'),
                );
              },
            ),
          ),
        ),
      ],
    );

    // Override the routerProvider to use this test router instance
    AppRouter.routerProvider.overrideCreator((ref) => router);

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    // Verify router is ready
    expect(find.text('Show Sheet'), findsOneWidget);

    // Trigger the bottom sheet
    await tester.tap(find.text('Show Sheet'));
    await tester.pumpAndSettle();

    // Verify bottom sheet content
    expect(find.text('Error de conexión'), findsOneWidget);
    expect(find.text('Network issue'), findsOneWidget);
    expect(find.text('Aceptar'), findsOneWidget);

    // Close the bottom sheet
    await tester.tap(find.text('Aceptar'));
    await tester.pumpAndSettle();

    expect(find.text('Error de conexión'), findsNothing);
  });
}

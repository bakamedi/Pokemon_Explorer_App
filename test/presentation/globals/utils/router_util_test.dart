import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_meedu/providers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_test/presentation/globals/utils/router_util.dart';
import 'package:poke_test/routes/app_pages.dart';
import 'package:poke_test/presentation/globals/controllers/navigator_key/navigator_key_gc.dart';

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  late MockGoRouter mockGoRouter;

  setUp(() {
    ProvidersContainer.clear();
    mockGoRouter = MockGoRouter();
  });

  test('RouterUtil delegates push, pushReplacement, go, and pop to GoRouter', () {
    // Override the creator of routerProvider to return our mockGoRouter
    AppRouter.routerProvider.overrideCreator((ref) => mockGoRouter);

    // Stub the mock router methods. GoRouter methods return void, so we just use when(...)
    when(() => mockGoRouter.push(any(), extra: any(named: 'extra'))).thenAnswer((_) async => null);
    when(() => mockGoRouter.pushReplacement(any(), extra: any(named: 'extra'))).thenAnswer((_) async => null);
    when(() => mockGoRouter.go(any(), extra: any(named: 'extra'))).thenAnswer((_) {});
    when(() => mockGoRouter.pop()).thenAnswer((_) {});

    // Call the RouterUtil methods
    RouterUtil.push('/test-route', extra: 'test-extra');
    RouterUtil.pushReplacement('/test-replacement', extra: 'test-extra-rep');
    RouterUtil.go('/test-go', extra: 'test-extra-go');
    RouterUtil.pop();

    // Verify correct calls on GoRouter
    verify(() => mockGoRouter.push('/test-route', extra: 'test-extra')).called(1);
    verify(() => mockGoRouter.pushReplacement('/test-replacement', extra: 'test-extra-rep')).called(1);
    verify(() => mockGoRouter.go('/test-go', extra: 'test-extra-go')).called(1);
    verify(() => mockGoRouter.pop()).called(1);
  });

  testWidgets('RouterUtil.context returns the current context of navigatorKey', (WidgetTester tester) async {
    final navKey = navigatorKeyGC.read().state.navigatorKey!;
    
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        home: Builder(
          builder: (context) {
            return const SizedBox();
          },
        ),
      ),
    );

    expect(RouterUtil.context, navKey.currentContext);
  });
}

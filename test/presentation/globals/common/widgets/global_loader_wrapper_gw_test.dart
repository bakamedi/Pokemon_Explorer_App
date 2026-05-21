import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_meedu/providers.dart';
import 'package:poke_test/presentation/globals/common/widgets/global_loader_wrapper_gw.dart';
import 'package:poke_test/presentation/globals/controllers/loader/loader_gc.dart';
import 'package:poke_test/presentation/globals/controllers/loader/loader_state.dart';
import 'package:poke_test/presentation/globals/controllers/navigator_key/navigator_key_gc.dart';
import 'package:lottie/lottie.dart';

void main() {
  setUp(() {
    ProvidersContainer.clear();
  });

  void setupLoader({required bool loading}) {
    loaderGlobalProvider.overrideCreator((_) => LoaderGC(
          LoaderState.initialState.copyWith(loading: loading),
        ));
  }

  testWidgets('GlobalLoaderWrapperGW - renders body and hides loading overlay by default', (WidgetTester tester) async {
    setupLoader(loading: false);
    final navKey = navigatorKeyGC.read().state.navigatorKey!;

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        home: const GlobalLoaderWrapperGW(
          body: Text('Main Body Text'),
        ),
      ),
    );

    expect(find.text('Main Body Text'), findsOneWidget);
    expect(find.byType(PopScope), findsNothing);
  });

  testWidgets('GlobalLoaderWrapperGW - renders body and shows loading overlay when loading is true', (WidgetTester tester) async {
    setupLoader(loading: true);
    final navKey = navigatorKeyGC.read().state.navigatorKey!;

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        home: const GlobalLoaderWrapperGW(
          body: Text('Main Body Text'),
        ),
      ),
    );

    expect(find.text('Main Body Text'), findsOneWidget);
    expect(find.byType(PopScope), findsOneWidget);
    expect(find.byType(BackdropFilter), findsOneWidget);
    expect(find.byType(Lottie), findsOneWidget);
  });
}

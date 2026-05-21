import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_meedu/providers.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/controllers/navigator_key/navigator_key_gc.dart';

void main() {
  setUp(() {
    ProvidersContainer.clear();
  });

  testWidgets('ResponsiveNumExt provides responsive dimensions based on screen size', (WidgetTester tester) async {
    final navKey = navigatorKeyGC.read().state.navigatorKey!;
    
    // Set up a test context with a known screen size
    // Design width is 402, design height is 874.
    // Let's use physical/screen size of width=804, height=1748 (exactly 2x design size).
    tester.view.physicalSize = const Size(804, 1748);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    double? rwVal;
    double? rhVal;
    double? spVal;
    double? rdVal;

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        home: Builder(
          builder: (context) {
            // Retrieve responsive values inside builder to ensure context is attached
            rwVal = 100.rw;
            rhVal = 100.rh;
            spVal = 100.sp;
            rdVal = 100.rd;
            return const SizedBox();
          },
        ),
      ),
    );

    // Verify expectations:
    // Scale width: 804 / 402 = 2.0. So 100.rw should be 200.0.
    expect(rwVal, closeTo(200.0, 0.001));

    // Scale height: 1748 / 874 = 2.0. So 100.rh should be 200.0.
    expect(rhVal, closeTo(200.0, 0.001));

    // Scale text: min(2.0, 2.0) = 2.0. But clamped between 0.85 and 1.25.
    // So scaleText clamped is 1.25.
    // 100.sp should be 100 * 1.25 = 125.0.
    expect(spVal, closeTo(125.0, 0.001));

    // Diagonal of 804x1748 is sqrt(804^2 + 1748^2) = 1923.68
    // Diagonal of 402x874 is sqrt(402^2 + 874^2) = 961.84
    // 1923.68 / 961.84 = 2.0.
    // So 100.rd should be 200.0.
    expect(rdVal, closeTo(200.0, 0.1));
  });
}

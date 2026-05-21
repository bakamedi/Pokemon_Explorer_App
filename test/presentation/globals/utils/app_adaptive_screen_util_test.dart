import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_meedu/providers.dart';
import 'package:poke_test/presentation/globals/utils/app_adaptive_screen_util.dart';
import 'package:poke_test/presentation/globals/controllers/navigator_key/navigator_key_gc.dart';

void main() {
  setUp(() {
    ProvidersContainer.clear();
  });

  test('AppAdaptiveScreenUtil throws FlutterError when navigator key context is null', () {
    expect(
      () => AppAdaptiveScreenUtil.rw(100.0),
      throwsA(isA<FlutterError>().having(
        (e) => e.message,
        'message',
        contains('navigatorKey.currentContext is null'),
      )),
    );
  });

  testWidgets('AppAdaptiveScreenUtil returns scaled screen dimensions', (WidgetTester tester) async {
    final navKey = navigatorKeyGC.read().state.navigatorKey!;
    
    // Design width 402, design height 874.
    // Set viewport to 804x1748 (exactly 2x design resolution).
    tester.view.physicalSize = const Size(804, 1748);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    double? rwVal;
    double? rhVal;
    double? rspVal;
    double? rdgVal;

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        home: Builder(
          builder: (context) {
            rwVal = AppAdaptiveScreenUtil.rw(100.0);
            rhVal = AppAdaptiveScreenUtil.rh(100.0);
            rspVal = AppAdaptiveScreenUtil.rsp(100.0);
            rdgVal = AppAdaptiveScreenUtil.rdg(100.0);
            return const SizedBox();
          },
        ),
      ),
    );

    // Verify correct scale calculations (2.0x scaling)
    expect(rwVal, closeTo(200.0, 0.001));
    expect(rhVal, closeTo(200.0, 0.001));
    // rsp has a clamp on min(widthScale, heightScale) = 2.0. Clamps to [0.85, 1.25]. So 100.0 * 1.25 = 125.0
    expect(rspVal, closeTo(125.0, 0.001));
    expect(rdgVal, closeTo(200.0, 0.1));
  });
}

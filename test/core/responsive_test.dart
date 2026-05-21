import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_test/core/responsive/responsive_screen.dart';
import 'package:poke_test/core/responsive/responsive_ext.dart';
import 'package:poke_test/core/responsive/responsive_font.dart';

void main() {
  group('ResponsiveScreen', () {
    testWidgets('calculates properties based on viewport size', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(804, 1748); // 2x design size
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      late ResponsiveScreen screen;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              screen = ResponsiveScreen(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(screen.width, 804.0);
      expect(screen.height, 1748.0);
      // rw(100) -> 100 * (804 / 402) = 200
      expect(screen.rw(100.0), closeTo(200.0, 0.001));
      // rh(100) -> 100 * (1748 / 874) = 200
      expect(screen.rh(100.0), closeTo(200.0, 0.001));
      // rsp(100) -> 100 * min(2, 2).clamp(0.85, 1.25) = 125
      expect(screen.rsp(100.0), closeTo(125.0, 0.001));
    });
  });

  group('ResponsiveExt', () {
    testWidgets('provides rs getter extension on BuildContext', (WidgetTester tester) async {
      late ResponsiveScreen screenFromExt;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              screenFromExt = context.rs;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(screenFromExt, isNotNull);
      expect(screenFromExt, isA<ResponsiveScreen>());
    });
  });

  group('ResponsiveFont', () {
    testWidgets('returns original size on phone device', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812); // phone
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      double? scaledSize;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              scaledSize = ResponsiveFont.scale(context, 16.0);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(scaledSize, 16.0);
    });

    testWidgets('returns 1.2x size on tablet device', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(768, 1024); // tablet
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      double? scaledSize;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              scaledSize = ResponsiveFont.scale(context, 16.0);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(scaledSize, closeTo(16.0 * 1.2, 0.001));
    });

    testWidgets('returns 1.35x size on desktop device', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1440, 900); // desktop
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      double? scaledSize;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              scaledSize = ResponsiveFont.scale(context, 16.0);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(scaledSize, closeTo(16.0 * 1.35, 0.001));
    });
  });
}

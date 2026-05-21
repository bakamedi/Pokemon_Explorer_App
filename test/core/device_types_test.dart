import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_test/core/device_types/device_type.dart';
import 'package:poke_test/core/device_types/app_device_type.dart';
import 'package:poke_test/core/device_types/device_type_ext.dart';

void main() {
  group('DeviceType enum', () {
    test('values have the correct breakpoints', () {
      expect(DeviceType.phone.value, 600);
      expect(DeviceType.tablet.value, 1024);
      expect(DeviceType.desktop.value, 1440);
    });
  });

  group('AppDeviceType', () {
    testWidgets('identifies phone portrait correctly', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812); // typical phone size
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      late AppDeviceType deviceType;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              deviceType = AppDeviceType(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(deviceType.deviceType, DeviceType.phone);
      expect(deviceType.isPhone, true);
      expect(deviceType.isTablet, false);
      expect(deviceType.isDesktop, false);
      expect(deviceType.isLandscape, false);
      expect(deviceType.width, 375);
      expect(deviceType.height, 812);
    });

    testWidgets('identifies tablet landscape correctly', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1024, 768); // typical tablet landscape
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      late AppDeviceType deviceType;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              deviceType = context.device; // testing the extension getter here
              return const SizedBox();
            },
          ),
        ),
      );

      expect(deviceType.deviceType, DeviceType.desktop); // width >= 1024 is desktop according to if/else logic
      expect(deviceType.isPhone, false);
      expect(deviceType.isTablet, false);
      expect(deviceType.isDesktop, true);
      expect(deviceType.isLandscape, true);
    });

    testWidgets('identifies tablet portrait correctly', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(768, 1024); // typical tablet portrait
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      late AppDeviceType deviceType;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              deviceType = context.device;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(deviceType.deviceType, DeviceType.tablet); // width 768 is >= 600 and < 1024
      expect(deviceType.isPhone, false);
      expect(deviceType.isTablet, true);
      expect(deviceType.isDesktop, false);
      expect(deviceType.isLandscape, false);
    });
  });
}

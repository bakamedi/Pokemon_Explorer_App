import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';

void main() {
  testWidgets('WidgetsExtension wraps widgets correctly', (WidgetTester tester) async {
    // 1. padding
    final widget1 = const Text('Test').padding(const EdgeInsets.all(8.0));
    expect(widget1, isA<Padding>());
    expect((widget1).padding, const EdgeInsets.all(8.0));

    // 2. expanded
    final widget2 = const Text('Test').expanded;
    expect(widget2, isA<Expanded>());
    expect((widget2).flex, 1);

    // 3. expandedFlex
    final widget3 = const Text('Test').expandedFlex(flex: 3);
    expect(widget3, isA<Expanded>());
    expect((widget3).flex, 3);

    // 4. flexible
    final widget4 = const Text('Test').flexible;
    expect(widget4, isA<Flexible>());

    // 5. center
    final widget5 = const Text('Test').center;
    expect(widget5, isA<Center>());

    // 6. sliverBox
    final widget6 = const Text('Test').sliverBox;
    expect(widget6, isA<SliverToBoxAdapter>());

    // 7. sliverPadding
    final widget7 = const Text('Test').sliverPadding(const EdgeInsets.all(12.0));
    expect(widget7, isA<SliverPadding>());
    expect((widget7).padding, const EdgeInsets.all(12.0));
  });

  test('SizedBoxWidgetDoubleExtension creates correct sized boxes', () {
    final double wVal = 10.0;
    final double hVal = 20.0;
    expect(wVal.w.width, 10.0);
    expect(hVal.h.height, 20.0);
  });

  test('SizedBoxWidgetIntExtension creates correct sized boxes', () {
    final int wVal = 15;
    final int hVal = 25;
    expect(wVal.w.width, 15.0);
    expect(hVal.h.height, 25.0);
  });
}

import 'package:flutter/widgets.dart';

extension WidgetsExtension on Widget {
  Padding padding(EdgeInsets padding) {
    return Padding(padding: padding, child: this);
  }

  Expanded get expanded => Expanded(child: this);

  Expanded expandedFlex({int flex = 1}) {
    return Expanded(flex: flex, child: this);
  }

  Flexible get flexible => Flexible(child: this);

  SliverToBoxAdapter get sliverBox => SliverToBoxAdapter(child: this);

  Center get center => Center(child: this);

  SliverPadding sliverPadding(EdgeInsets padding) =>
      SliverPadding(padding: padding, sliver: this);
}

extension SizedBoxWidgetDoubleExtension on double {
  SizedBox get w => SizedBox(width: this);
  SizedBox get h => SizedBox(height: this);
}

extension SizedBoxWidgetIntExtension on int {
  SizedBox get w => SizedBox(width: toDouble());
  SizedBox get h => SizedBox(height: toDouble());
}

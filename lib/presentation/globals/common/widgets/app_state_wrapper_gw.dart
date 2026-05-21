import 'package:flutter/material.dart';
import 'package:poke_test/presentation/globals/common/widgets/error_gw.dart';

import '../../extensions/widgets_ext.dart';
import '../../utils/app_view_state_util.dart';

class AppStateWrapperGW extends StatelessWidget {
  const AppStateWrapperGW({
    super.key,
    required this.appViewStateUtil,
    required this.onSuccess,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
    this.idleWidget,
  });

  /// Obligatorios
  final AppViewStateUtil appViewStateUtil;
  final Widget Function(BuildContext context) onSuccess;

  /// Opcionales
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget? emptyWidget;
  final Widget? idleWidget;

  @override
  Widget build(BuildContext context) {
    switch (appViewStateUtil) {
      case .loading:
        return loadingWidget ??
            const CircularProgressIndicator.adaptive().center;
      case .error:
        return errorWidget ?? const ErrorGW();
      case .empty:
        return emptyWidget ?? Text('No hay datos').center;
      case .success:
        return onSuccess(context);
      case .idle:
        return idleWidget ?? const SizedBox.shrink();
    }
  }
}

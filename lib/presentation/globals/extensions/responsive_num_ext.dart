import '../utils/app_adaptive_screen_util.dart';

extension ResponsiveNumExt on num {
  double get rw => AppAdaptiveScreenUtil.rw(toDouble());

  double get rh => AppAdaptiveScreenUtil.rh(toDouble());

  double get sp => AppAdaptiveScreenUtil.rsp(toDouble());

  double get rd => AppAdaptiveScreenUtil.rdg(toDouble());
}

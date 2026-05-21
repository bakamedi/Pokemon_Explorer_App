import 'package:flutter_test/flutter_test.dart';
import 'package:poke_test/presentation/globals/utils/app_view_state_util.dart';

void main() {
  group('AppViewStateUtil', () {
    test('enum should have the correct values', () {
      expect(AppViewStateUtil.values, [
        AppViewStateUtil.idle,
        AppViewStateUtil.loading,
        AppViewStateUtil.success,
        AppViewStateUtil.error,
        AppViewStateUtil.empty,
      ]);
    });
  });
}

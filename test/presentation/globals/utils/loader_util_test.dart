import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_meedu/providers.dart';
import 'package:poke_test/presentation/globals/utils/loader_util.dart';
import 'package:poke_test/presentation/globals/controllers/loader/loader_gc.dart';

void main() {
  setUp(() {
    ProvidersContainer.clear();
  });

  group('LoaderUtil', () {
    test('show() sets loader state loading to true', () {
      final loaderGC = loaderGlobalProvider.read();
      expect(loaderGC.state.loading, false);

      LoaderUtil.show();
      expect(loaderGC.state.loading, true);
    });

    test('hide() sets loader state loading to false', () {
      final loaderGC = loaderGlobalProvider.read();
      loaderGC.showLoader(loading: true);
      expect(loaderGC.state.loading, true);

      LoaderUtil.hide();
      expect(loaderGC.state.loading, false);
    });
  });
}

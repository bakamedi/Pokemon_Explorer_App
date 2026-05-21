import '../controllers/loader/loader_gc.dart';

abstract class LoaderUtil {
  static LoaderGC get _loader => loaderGlobalProvider.read();

  static void show() {
    _loader.showLoader(loading: true);
  }

  static void hide() {
    _loader.showLoader(loading: false);
  }
}

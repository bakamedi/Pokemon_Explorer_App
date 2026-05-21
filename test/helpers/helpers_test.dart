import 'package:flutter_test/flutter_test.dart';
import 'package:poke_test/helpers/assets_image_helper.dart';
import 'package:poke_test/helpers/assets_lottie_helper.dart';

void main() {
  group('AssetsImageHelper', () {
    test('pokeball constant is correct', () {
      expect(AssetsImageHelper.pokeball, 'assets/images/pokeball.png');
    });
  });

  group('AssetsLottieHelper', () {
    test('pokeballLoading constant is correct', () {
      expect(AssetsLottieHelper.pokeballLoading, 'assets/lotties/pokeball_loading.json');
    });
  });
}

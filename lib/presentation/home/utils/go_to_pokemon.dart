import 'package:poke_test/presentation/globals/utils/router_util.dart';

void goToPokemon(int id) {
  RouterUtil.push('/pokemon-detail/$id');
}

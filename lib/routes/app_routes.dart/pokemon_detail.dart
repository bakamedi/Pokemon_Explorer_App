import 'package:go_router/go_router.dart';
import 'package:poke_test/presentation/modules/pokemon_detail/view/pokemon_detail_page.dart';


class PokemonDetailRoute {
  static const path = '/pokemon-detail/:id';

  static GoRoute get route {
    return GoRoute(
      path: path,
      builder: (context, state) {
        final idString = state.pathParameters['id'] ?? '0';
        final pokemonId = int.tryParse(idString) ?? 0;
        
        return PokemonDetailPage(pokemonId: pokemonId);
      },
    );
  }
}

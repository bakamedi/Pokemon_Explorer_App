import 'package:flutter_meedu/providers.dart';
import 'package:poke_test/data/injects/providers/app_inject_providers.dart';
import 'package:poke_test/data/repositories_impl/index_repositories_impl.dart';
import 'package:poke_test/domain/repositories/index_repositories.dart';


class AppInjectRepositories {
  const AppInjectRepositories._();

  static final authRep = Provider<AuthRepository>(
    (ref) => AuthRepositoryImpl(
      authProvider: AppProviderInjects.authProvider.read(),
    ),
  );


  static final pokemonRep = Provider<PokemonRepository>(
    (ref) => PokemonRepositoryImpl(
      pokemonProvider: AppProviderInjects.pokemonProvider.read(),
    ),
  );

}

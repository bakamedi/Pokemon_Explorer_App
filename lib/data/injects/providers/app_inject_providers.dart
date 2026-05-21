import 'package:flutter_meedu/providers.dart';
import 'package:poke_test/core/instances/dio_i/dio_instance.dart';
import 'package:poke_test/data/helpers/http/http_helper.dart';
import 'package:poke_test/data/providers/index_providers.dart';

class AppProviderInjects {
  AppProviderInjects._();

  static final authProvider = Provider((_) => AuthProvider());

  static final pokemonProvider = Provider(
    (_) => PokemonProvider(
      httpHelper: HttpHelper(dio: DioInstance.dio),
      basePath: 'pokemon',
    ),
  );

  static final deviceProvider = Provider((_) => DeviceUtilProvider());
}

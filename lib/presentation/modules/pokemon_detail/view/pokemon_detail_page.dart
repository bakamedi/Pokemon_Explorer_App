import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';
import 'package:poke_test/presentation/globals/common/widgets/app_state_wrapper_gw.dart';
import 'package:poke_test/presentation/globals/extensions/pokemon_detail_model_ext.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/presentation/modules/pokemon_detail/controller/pokemon_detail_controller.dart';
import 'package:poke_test/presentation/modules/pokemon_detail/view/widgets/pokemon_abilities_w.dart';
import 'package:poke_test/presentation/modules/pokemon_detail/view/widgets/pokemon_artwork_w.dart';
import 'package:poke_test/presentation/modules/pokemon_detail/view/widgets/pokemon_base_stats_w.dart';
import 'package:poke_test/presentation/modules/pokemon_detail/view/widgets/pokemon_detail_loading_page_w.dart';
import 'package:poke_test/presentation/modules/pokemon_detail/view/widgets/pokemon_dimensions_w.dart';
import 'package:poke_test/presentation/modules/pokemon_detail/view/widgets/pokemon_types_w.dart';

class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({super.key, required this.pokemonId});

  final int pokemonId;

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  @override
  void initState() {
    super.initState();

    final controller = pokemonDetailProvider.read();
    controller.onChangeId(widget.pokemonId);
    controller.loadPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Consumer(
        builder: (_, ref, _) {
          final controller = ref.watch(pokemonDetailProvider);

          return AppStateWrapperGW(
            appViewStateUtil: controller.state.appViewStateUtil,
            loadingWidget: const PokemonDetailLoadingPageW(),
            onSuccess: (_) {
              final pokemon = controller.state.pokemon;

              if (pokemon == null) {
                return Text('No se encontraron detalles del pokemon.').center;
              }

              return Scaffold(
                backgroundColor: Colors.grey.shade50,
                appBar: AppBar(
                  title: Text(
                    '${pokemon.name.toUpperCase()} ${pokemon.formattedId}',
                    style: TextStyle(fontWeight: .bold, fontSize: 18.sp),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  padding: const .all(20),
                  child: Column(
                    spacing: 24,
                    crossAxisAlignment: .start,
                    children: [
                      PokemonArtworkW(pokemon: pokemon),
                      PokemonTypesW(types: pokemon.types),
                      PokemonDimensionsW(
                        weightInKg: pokemon.weightInKg,
                        heightInM: pokemon.heightInM,
                      ),
                      PokemonAbilitiesW(abilities: pokemon.abilities),
                      PokemonBaseStatsW(stats: pokemon.stats),
                      20.h,
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

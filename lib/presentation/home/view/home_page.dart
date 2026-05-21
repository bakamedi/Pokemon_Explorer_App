import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';
import 'package:poke_test/presentation/globals/common/widgets/app_state_wrapper_gw.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/presentation/home/controller/home_controller.dart';
import 'package:poke_test/presentation/home/view/widgets/close_session_w.dart';
import 'package:poke_test/presentation/home/view/widgets/home_body_w.dart';
import 'package:poke_test/presentation/home/view/widgets/home_loading_body_w.dart';
import 'package:poke_test/presentation/home/view/widgets/home_search_w.dart';
import 'package:poke_test/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Pokémon Explorer App'),
        backgroundColor: AppColors.primaryRed,
        actions: [
          CloseSessionW(),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer(
        builder: (_, ref, _) {
          final controller = ref.watch(homeProvider);

          return AppStateWrapperGW(
            appViewStateUtil: controller.state.appViewStateUtil,
            loadingWidget: const HomeLoadingBodyW(),
            onSuccess: (context) {
              return Column(
                crossAxisAlignment: .start,
                children: [
                  HomeSearchW(),
                  24.h,

                  Text(
                    'AVAILABLE POKÉMON (${controller.state.pokemonResponse!.results.length}-${controller.state.pokemonResponse!.count})',
                    style: TextStyle(fontWeight: .bold, letterSpacing: .5),
                  ),
                  16.h,

                  if (controller.state.pokemonResponse != null)
                    if (controller.state.searchResult != null &&
                        controller.state.searchResult!.isNotEmpty)
                      HomeBodyW(result: controller.state.searchResult)
                    else
                      HomeBodyW(
                        result: controller.state.pokemonResponse!.results,
                      )
                  else
                    const SizedBox.shrink(),
                ],
              ).padding(
                const .symmetric(horizontal: 16, vertical: 16),
              ); // Corregido .symmetric
            },
          );
        },
      ),
    );
  }
}

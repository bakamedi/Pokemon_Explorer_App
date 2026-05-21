import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';
import 'package:flutter_meedu/provider/filters.dart';
import 'package:poke_test/domain/responses/pokemon_response_model.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/presentation/home/controller/home_controller.dart';
import 'package:poke_test/presentation/home/view/widgets/home_item_w.dart';
import 'package:poke_test/presentation/home/view/widgets/item_home_loading_w.dart'; // Tu import del Shimmer Grid

class HomeBodyW extends ConsumerStatefulWidget {
  const HomeBodyW({super.key, required this.result});

  final List<PokemonModel>? result;

  @override
  ConsumerState<HomeBodyW> createState() => _HomeBodyWState();
}

class _HomeBodyWState extends ConsumerState<HomeBodyW> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      homeProvider.read().loadMorePokemons();
    }
  }

  @override
  Widget build(BuildContext context) {
    final results = widget.result ?? [];

    final isLoadMore = ref.select(
      homeProvider.select((state) => state.isLoadMore),
    );

    return GridView.builder(
      keyboardDismissBehavior: .onDrag,
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemCount: results.length + (isLoadMore ? 2 : 0),
      itemBuilder: (context, index) {
        if (index >= results.length) {
          return const ItemHomeLoadingW();
        }

        return ItemHomeW(pokemon: results[index]);
      },
    ).expanded;
  }
}

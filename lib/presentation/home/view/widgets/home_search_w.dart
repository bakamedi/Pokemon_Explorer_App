import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';
import 'package:flutter_meedu/provider/filters.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/home/controller/home_controller.dart';

class HomeSearchW extends StatelessWidget {
  const HomeSearchW({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, _) {
        final searchLoading = ref.select(
          homeProvider.select((s) => s.searchLoading),
        );
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: .circular(16),
          ),
          child: TextField(
            onChanged: (value) {
              homeProvider.read().onSearchChanged(value);
            },
            textInputAction: .search,
            decoration: InputDecoration(
              hintText: 'Buscar Pokémon por nombre o ID',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchLoading
                  ? const Padding(
                      padding: .all(12.0),
                      child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                    )
                  : null,
              border: .none,
              contentPadding: .symmetric(horizontal: 16.rw, vertical: 16.rh),
            ),
          ),
        );
      },
    );
  }
}

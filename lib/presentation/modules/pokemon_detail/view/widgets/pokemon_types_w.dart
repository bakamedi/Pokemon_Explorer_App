import 'package:flutter/material.dart';
import 'package:poke_test/domain/models/pokemon_detail_model.dart';
import 'package:poke_test/presentation/globals/extensions/pokemon_string_ext.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';

class PokemonTypesW extends StatelessWidget {
  const PokemonTypesW({super.key, required this.types});

  final List<TypeSlot> types;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.rw,
      children: types.map((typeSlot) {
        final typeName = typeSlot.type.name;
        return Container(
          padding: .symmetric(horizontal: 16.rw, vertical: 6.rh),
          decoration: BoxDecoration(
            color: typeName.toPokemonTypeColor,
            borderRadius: .circular(12.rw),
            boxShadow: [
              BoxShadow(
                color: typeName.toPokemonTypeColor.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            typeName.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: .bold,
              fontSize: 12.sp,
              letterSpacing: 0.5,
            ),
          ),
        );
      }).toList(),
    );
  }
}

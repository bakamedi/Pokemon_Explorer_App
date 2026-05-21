import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_detail_model.freezed.dart';
part 'pokemon_detail_model.g.dart';

@freezed
abstract class PokemonDetailModel with _$PokemonDetailModel {
  const PokemonDetailModel._();

  const factory PokemonDetailModel({
    required int id,
    required String name,
    required int height,
    required int weight,
    required List<TypeSlot> types,
    required List<AbilitySlot> abilities,
    required List<StatSlot> stats,
  }) = _PokemonDetailModel;

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailModelFromJson(json);
}

@freezed
abstract class TypeSlot with _$TypeSlot {
  const factory TypeSlot({required int slot, required NamedAPIResource type}) =
      _TypeSlot;

  factory TypeSlot.fromJson(Map<String, dynamic> json) =>
      _$TypeSlotFromJson(json);
}

@freezed
abstract class AbilitySlot with _$AbilitySlot {
  const factory AbilitySlot({
    required int slot,
    @JsonKey(name: 'is_hidden') required bool isHidden,
    required NamedAPIResource ability,
  }) = _AbilitySlot;

  factory AbilitySlot.fromJson(Map<String, dynamic> json) =>
      _$AbilitySlotFromJson(json);
}

@freezed
abstract class StatSlot with _$StatSlot {
  const factory StatSlot({
    @JsonKey(name: 'base_stat') required int baseStat,
    required int effort,
    required NamedAPIResource stat,
  }) = _StatSlot;

  factory StatSlot.fromJson(Map<String, dynamic> json) =>
      _$StatSlotFromJson(json);
}

@freezed
abstract class NamedAPIResource with _$NamedAPIResource {
  const factory NamedAPIResource({required String name, required String url}) =
      _NamedAPIResource;

  factory NamedAPIResource.fromJson(Map<String, dynamic> json) =>
      _$NamedAPIResourceFromJson(json);
}

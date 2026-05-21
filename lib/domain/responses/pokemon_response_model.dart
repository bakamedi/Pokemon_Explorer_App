import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_response_model.freezed.dart';
part 'pokemon_response_model.g.dart';

@freezed
abstract class PokemonResponseModel with _$PokemonResponseModel {
  const factory PokemonResponseModel({
    required int count,
    required String? next,
    required String? previous,
    required List<PokemonModel> results,
  }) = _PokemonResponseModel;

  factory PokemonResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonResponseModelFromJson(json);
}

@freezed
abstract class PokemonModel with _$PokemonModel {
  const factory PokemonModel({required String name, required String url}) =
      _PokemonModel;

  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);
}

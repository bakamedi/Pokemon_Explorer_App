
import 'package:freezed_annotation/freezed_annotation.dart';

part 'loader_state.freezed.dart';

@freezed
abstract class LoaderState with _$LoaderState {
  const LoaderState._();
  const factory LoaderState({
    @Default(false) bool loading,
  }) = _LoaderState;
  static LoaderState get initialState => const LoaderState();
}

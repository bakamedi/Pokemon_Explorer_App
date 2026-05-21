import 'package:freezed_annotation/freezed_annotation.dart';

part 'either.freezed.dart';

@freezed
abstract class Either<L, R> with _$Either<L, R> {
  const Either._();

  const factory Either.left(L value) = _Left<L, R>;
  const factory Either.right(R value) = _Right<L, R>;

  bool get isRight => this is _Right<L, R>;
  bool get isLeft => this is _Left<L, R>;

  R? getRightOrNull() => when(left: (_) => null, right: (r) => r);
  L? getLeftOrNull() => when(left: (l) => l, right: (_) => null);

  T fold<T>(T Function(L l) onLeft, T Function(R r) onRight) {
    return when(left: onLeft, right: onRight);
  }

  T either<T>(T Function(L l) leftFn, T Function(R r) rightFn) =>
      fold(leftFn, rightFn);

  void ifRight(void Function(R value) fn) {
    when(left: (_) {}, right: fn);
  }

  void ifLeft(void Function(L value) fn) {
    when(left: fn, right: (_) {});
  }

  Future<void> ifRightAsync(Future<void> Function(R value) fn) async {
    await when(left: (_) async {}, right: fn);
  }

  Either<L, R2> map<R2>(R2 Function(R r) fn) =>
      when(left: (l) => Either.left(l), right: (r) => Either.right(fn(r)));

  Either<L2, R> mapLeft<L2>(L2 Function(L l) fn) =>
      when(left: (l) => Either.left(fn(l)), right: (r) => Either.right(r));

  Either<L, R2> flatMap<R2>(Either<L, R2> Function(R r) fn) =>
      when(left: (l) => Either.left(l), right: fn);

  Future<Either<L, R2>> asyncFlatMap<R2>(
    Future<Either<L, R2>> Function(R r) fn,
  ) async {
    return await when(left: (l) async => Either.left(l), right: fn);
  }

  R getOrElse(R Function() orElse) =>
      when(left: (_) => orElse(), right: (r) => r);
}

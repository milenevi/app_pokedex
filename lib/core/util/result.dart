import '../error/failures.dart';

class Result<T> {
  final T? data;
  final Failure? failure;

  Result._({this.data, this.failure});

  factory Result.success(T data) => Result._(data: data);

  factory Result.failure(Failure failure) => Result._(failure: failure);

  bool get isSuccess => failure == null;
  bool get isFailure => failure != null;

  R fold<R>(
    R Function(T data) onSuccess,
    R Function(Failure failure) onFailure,
  ) {
    if (isSuccess) {
      return onSuccess(data as T);
    } else {
      return onFailure(failure!);
    }
  }
}

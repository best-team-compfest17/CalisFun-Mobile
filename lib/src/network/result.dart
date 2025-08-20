// lib/src/network/result.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'network_exception.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(NetworkExceptions error) = Failure<T>;
}
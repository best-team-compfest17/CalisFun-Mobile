// lib/src/network/network_exceptions.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exception.freezed.dart';

@freezed
class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;
  const factory NetworkExceptions.unauthorizedRequest() = UnauthorizedRequest;
  const factory NetworkExceptions.badRequest([String? reason]) = BadRequest;
  const factory NetworkExceptions.notFound([String? reason]) = NotFound;
  const factory NetworkExceptions.internalServerError([String? reason]) = InternalServerError;
  const factory NetworkExceptions.serviceUnavailable([String? reason]) = ServiceUnavailable;
  const factory NetworkExceptions.timeout() = Timeout;
  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;
  const factory NetworkExceptions.unexpectedError([String? reason]) = UnexpectedError;
}

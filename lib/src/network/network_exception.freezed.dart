// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NetworkExceptions {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkExceptions);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkExceptions()';
}


}

/// @nodoc
class $NetworkExceptionsCopyWith<$Res>  {
$NetworkExceptionsCopyWith(NetworkExceptions _, $Res Function(NetworkExceptions) __);
}


/// Adds pattern-matching-related methods to [NetworkExceptions].
extension NetworkExceptionsPatterns on NetworkExceptions {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RequestCancelled value)?  requestCancelled,TResult Function( UnauthorizedRequest value)?  unauthorizedRequest,TResult Function( BadRequest value)?  badRequest,TResult Function( NotFound value)?  notFound,TResult Function( InternalServerError value)?  internalServerError,TResult Function( ServiceUnavailable value)?  serviceUnavailable,TResult Function( Timeout value)?  timeout,TResult Function( NoInternetConnection value)?  noInternetConnection,TResult Function( UnexpectedError value)?  unexpectedError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RequestCancelled() when requestCancelled != null:
return requestCancelled(_that);case UnauthorizedRequest() when unauthorizedRequest != null:
return unauthorizedRequest(_that);case BadRequest() when badRequest != null:
return badRequest(_that);case NotFound() when notFound != null:
return notFound(_that);case InternalServerError() when internalServerError != null:
return internalServerError(_that);case ServiceUnavailable() when serviceUnavailable != null:
return serviceUnavailable(_that);case Timeout() when timeout != null:
return timeout(_that);case NoInternetConnection() when noInternetConnection != null:
return noInternetConnection(_that);case UnexpectedError() when unexpectedError != null:
return unexpectedError(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RequestCancelled value)  requestCancelled,required TResult Function( UnauthorizedRequest value)  unauthorizedRequest,required TResult Function( BadRequest value)  badRequest,required TResult Function( NotFound value)  notFound,required TResult Function( InternalServerError value)  internalServerError,required TResult Function( ServiceUnavailable value)  serviceUnavailable,required TResult Function( Timeout value)  timeout,required TResult Function( NoInternetConnection value)  noInternetConnection,required TResult Function( UnexpectedError value)  unexpectedError,}){
final _that = this;
switch (_that) {
case RequestCancelled():
return requestCancelled(_that);case UnauthorizedRequest():
return unauthorizedRequest(_that);case BadRequest():
return badRequest(_that);case NotFound():
return notFound(_that);case InternalServerError():
return internalServerError(_that);case ServiceUnavailable():
return serviceUnavailable(_that);case Timeout():
return timeout(_that);case NoInternetConnection():
return noInternetConnection(_that);case UnexpectedError():
return unexpectedError(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RequestCancelled value)?  requestCancelled,TResult? Function( UnauthorizedRequest value)?  unauthorizedRequest,TResult? Function( BadRequest value)?  badRequest,TResult? Function( NotFound value)?  notFound,TResult? Function( InternalServerError value)?  internalServerError,TResult? Function( ServiceUnavailable value)?  serviceUnavailable,TResult? Function( Timeout value)?  timeout,TResult? Function( NoInternetConnection value)?  noInternetConnection,TResult? Function( UnexpectedError value)?  unexpectedError,}){
final _that = this;
switch (_that) {
case RequestCancelled() when requestCancelled != null:
return requestCancelled(_that);case UnauthorizedRequest() when unauthorizedRequest != null:
return unauthorizedRequest(_that);case BadRequest() when badRequest != null:
return badRequest(_that);case NotFound() when notFound != null:
return notFound(_that);case InternalServerError() when internalServerError != null:
return internalServerError(_that);case ServiceUnavailable() when serviceUnavailable != null:
return serviceUnavailable(_that);case Timeout() when timeout != null:
return timeout(_that);case NoInternetConnection() when noInternetConnection != null:
return noInternetConnection(_that);case UnexpectedError() when unexpectedError != null:
return unexpectedError(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  requestCancelled,TResult Function()?  unauthorizedRequest,TResult Function( String? reason)?  badRequest,TResult Function( String? reason)?  notFound,TResult Function( String? reason)?  internalServerError,TResult Function( String? reason)?  serviceUnavailable,TResult Function()?  timeout,TResult Function()?  noInternetConnection,TResult Function( String? reason)?  unexpectedError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RequestCancelled() when requestCancelled != null:
return requestCancelled();case UnauthorizedRequest() when unauthorizedRequest != null:
return unauthorizedRequest();case BadRequest() when badRequest != null:
return badRequest(_that.reason);case NotFound() when notFound != null:
return notFound(_that.reason);case InternalServerError() when internalServerError != null:
return internalServerError(_that.reason);case ServiceUnavailable() when serviceUnavailable != null:
return serviceUnavailable(_that.reason);case Timeout() when timeout != null:
return timeout();case NoInternetConnection() when noInternetConnection != null:
return noInternetConnection();case UnexpectedError() when unexpectedError != null:
return unexpectedError(_that.reason);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  requestCancelled,required TResult Function()  unauthorizedRequest,required TResult Function( String? reason)  badRequest,required TResult Function( String? reason)  notFound,required TResult Function( String? reason)  internalServerError,required TResult Function( String? reason)  serviceUnavailable,required TResult Function()  timeout,required TResult Function()  noInternetConnection,required TResult Function( String? reason)  unexpectedError,}) {final _that = this;
switch (_that) {
case RequestCancelled():
return requestCancelled();case UnauthorizedRequest():
return unauthorizedRequest();case BadRequest():
return badRequest(_that.reason);case NotFound():
return notFound(_that.reason);case InternalServerError():
return internalServerError(_that.reason);case ServiceUnavailable():
return serviceUnavailable(_that.reason);case Timeout():
return timeout();case NoInternetConnection():
return noInternetConnection();case UnexpectedError():
return unexpectedError(_that.reason);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  requestCancelled,TResult? Function()?  unauthorizedRequest,TResult? Function( String? reason)?  badRequest,TResult? Function( String? reason)?  notFound,TResult? Function( String? reason)?  internalServerError,TResult? Function( String? reason)?  serviceUnavailable,TResult? Function()?  timeout,TResult? Function()?  noInternetConnection,TResult? Function( String? reason)?  unexpectedError,}) {final _that = this;
switch (_that) {
case RequestCancelled() when requestCancelled != null:
return requestCancelled();case UnauthorizedRequest() when unauthorizedRequest != null:
return unauthorizedRequest();case BadRequest() when badRequest != null:
return badRequest(_that.reason);case NotFound() when notFound != null:
return notFound(_that.reason);case InternalServerError() when internalServerError != null:
return internalServerError(_that.reason);case ServiceUnavailable() when serviceUnavailable != null:
return serviceUnavailable(_that.reason);case Timeout() when timeout != null:
return timeout();case NoInternetConnection() when noInternetConnection != null:
return noInternetConnection();case UnexpectedError() when unexpectedError != null:
return unexpectedError(_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class RequestCancelled implements NetworkExceptions {
  const RequestCancelled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestCancelled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkExceptions.requestCancelled()';
}


}




/// @nodoc


class UnauthorizedRequest implements NetworkExceptions {
  const UnauthorizedRequest();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnauthorizedRequest);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkExceptions.unauthorizedRequest()';
}


}




/// @nodoc


class BadRequest implements NetworkExceptions {
  const BadRequest([this.reason]);
  

 final  String? reason;

/// Create a copy of NetworkExceptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BadRequestCopyWith<BadRequest> get copyWith => _$BadRequestCopyWithImpl<BadRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BadRequest&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'NetworkExceptions.badRequest(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $BadRequestCopyWith<$Res> implements $NetworkExceptionsCopyWith<$Res> {
  factory $BadRequestCopyWith(BadRequest value, $Res Function(BadRequest) _then) = _$BadRequestCopyWithImpl;
@useResult
$Res call({
 String? reason
});




}
/// @nodoc
class _$BadRequestCopyWithImpl<$Res>
    implements $BadRequestCopyWith<$Res> {
  _$BadRequestCopyWithImpl(this._self, this._then);

  final BadRequest _self;
  final $Res Function(BadRequest) _then;

/// Create a copy of NetworkExceptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = freezed,}) {
  return _then(BadRequest(
freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class NotFound implements NetworkExceptions {
  const NotFound([this.reason]);
  

 final  String? reason;

/// Create a copy of NetworkExceptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotFoundCopyWith<NotFound> get copyWith => _$NotFoundCopyWithImpl<NotFound>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotFound&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'NetworkExceptions.notFound(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $NotFoundCopyWith<$Res> implements $NetworkExceptionsCopyWith<$Res> {
  factory $NotFoundCopyWith(NotFound value, $Res Function(NotFound) _then) = _$NotFoundCopyWithImpl;
@useResult
$Res call({
 String? reason
});




}
/// @nodoc
class _$NotFoundCopyWithImpl<$Res>
    implements $NotFoundCopyWith<$Res> {
  _$NotFoundCopyWithImpl(this._self, this._then);

  final NotFound _self;
  final $Res Function(NotFound) _then;

/// Create a copy of NetworkExceptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = freezed,}) {
  return _then(NotFound(
freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class InternalServerError implements NetworkExceptions {
  const InternalServerError([this.reason]);
  

 final  String? reason;

/// Create a copy of NetworkExceptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InternalServerErrorCopyWith<InternalServerError> get copyWith => _$InternalServerErrorCopyWithImpl<InternalServerError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InternalServerError&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'NetworkExceptions.internalServerError(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $InternalServerErrorCopyWith<$Res> implements $NetworkExceptionsCopyWith<$Res> {
  factory $InternalServerErrorCopyWith(InternalServerError value, $Res Function(InternalServerError) _then) = _$InternalServerErrorCopyWithImpl;
@useResult
$Res call({
 String? reason
});




}
/// @nodoc
class _$InternalServerErrorCopyWithImpl<$Res>
    implements $InternalServerErrorCopyWith<$Res> {
  _$InternalServerErrorCopyWithImpl(this._self, this._then);

  final InternalServerError _self;
  final $Res Function(InternalServerError) _then;

/// Create a copy of NetworkExceptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = freezed,}) {
  return _then(InternalServerError(
freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ServiceUnavailable implements NetworkExceptions {
  const ServiceUnavailable([this.reason]);
  

 final  String? reason;

/// Create a copy of NetworkExceptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceUnavailableCopyWith<ServiceUnavailable> get copyWith => _$ServiceUnavailableCopyWithImpl<ServiceUnavailable>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceUnavailable&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'NetworkExceptions.serviceUnavailable(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $ServiceUnavailableCopyWith<$Res> implements $NetworkExceptionsCopyWith<$Res> {
  factory $ServiceUnavailableCopyWith(ServiceUnavailable value, $Res Function(ServiceUnavailable) _then) = _$ServiceUnavailableCopyWithImpl;
@useResult
$Res call({
 String? reason
});




}
/// @nodoc
class _$ServiceUnavailableCopyWithImpl<$Res>
    implements $ServiceUnavailableCopyWith<$Res> {
  _$ServiceUnavailableCopyWithImpl(this._self, this._then);

  final ServiceUnavailable _self;
  final $Res Function(ServiceUnavailable) _then;

/// Create a copy of NetworkExceptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = freezed,}) {
  return _then(ServiceUnavailable(
freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class Timeout implements NetworkExceptions {
  const Timeout();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Timeout);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkExceptions.timeout()';
}


}




/// @nodoc


class NoInternetConnection implements NetworkExceptions {
  const NoInternetConnection();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoInternetConnection);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkExceptions.noInternetConnection()';
}


}




/// @nodoc


class UnexpectedError implements NetworkExceptions {
  const UnexpectedError([this.reason]);
  

 final  String? reason;

/// Create a copy of NetworkExceptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnexpectedErrorCopyWith<UnexpectedError> get copyWith => _$UnexpectedErrorCopyWithImpl<UnexpectedError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnexpectedError&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'NetworkExceptions.unexpectedError(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $UnexpectedErrorCopyWith<$Res> implements $NetworkExceptionsCopyWith<$Res> {
  factory $UnexpectedErrorCopyWith(UnexpectedError value, $Res Function(UnexpectedError) _then) = _$UnexpectedErrorCopyWithImpl;
@useResult
$Res call({
 String? reason
});




}
/// @nodoc
class _$UnexpectedErrorCopyWithImpl<$Res>
    implements $UnexpectedErrorCopyWith<$Res> {
  _$UnexpectedErrorCopyWithImpl(this._self, this._then);

  final UnexpectedError _self;
  final $Res Function(UnexpectedError) _then;

/// Create a copy of NetworkExceptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = freezed,}) {
  return _then(UnexpectedError(
freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

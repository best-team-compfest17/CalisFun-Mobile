import 'package:flutter_riverpod/flutter_riverpod.dart';

class SigninState {
  final AsyncValue<void> loginValue;
  final bool isObscure;
  final String email;
  final String password;

  const SigninState({
    this.loginValue = const AsyncData(null),
    this.isObscure = true,
    this.email = '',
    this.password = '',
  });

  bool get isLoading => loginValue.isLoading;
  bool get isValidEmail =>
      RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email.trim());
  bool get isValidPassword => password.length >= 6;
  bool get canSubmit => isValidEmail && isValidPassword && !isLoading;

  SigninState copyWith({
    AsyncValue<void>? loginValue,
    bool? isObscure,
    String? email,
    String? password,
  }) {
    return SigninState(
      loginValue: loginValue ?? this.loginValue,
      isObscure: isObscure ?? this.isObscure,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

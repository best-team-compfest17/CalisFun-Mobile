import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core.dart';

class SigninState {
  final AsyncValue<User?> signinValue;
  final bool isObscure;
  final String email;
  final String password;

  const SigninState({
    this.signinValue = const AsyncData<User?>(null),
    this.isObscure = true,
    this.email = '',
    this.password = '',
  });

  bool get isLoading => signinValue.isLoading;
  bool get isValidEmail =>
      RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email.trim());
  bool get isValidPassword => password.length >= 6;
  bool get canSubmit => isValidEmail && isValidPassword && !isLoading;

  SigninState copyWith({
    AsyncValue<User?>? signinValue,
    bool? isObscure,
    String? email,
    String? password,
  }) {
    return SigninState(
      signinValue: signinValue ?? this.signinValue,
      isObscure: isObscure ?? this.isObscure,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

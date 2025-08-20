import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core.dart';

class SignupState {
  final AsyncValue<User?> signupValue;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;

  final bool isObscurePassword;
  final bool isObscureConfirm;
  final bool agreedTnC;

  const SignupState({
    this.signupValue = const AsyncData<User?>(null),
    this.name = '',
    this.email = '',
    this.phone = '',
    this.password = '',
    this.confirmPassword = '',
    this.isObscurePassword = true,
    this.isObscureConfirm = true,
    this.agreedTnC = false,
  });

  bool get isLoading => signupValue.isLoading;

  bool get isValidName => name.trim().length >= 2;
  bool get isValidEmail =>
      RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email.trim());
  bool get isValidPhone =>
      RegExp(r'^[0-9]{9,15}$').hasMatch(phone.replaceAll(' ', ''));
  bool get isValidPassword => password.length >= 6;
  bool get isPasswordMatch => confirmPassword == password;

  bool get canSubmit =>
      isValidName &&
          isValidEmail &&
          isValidPhone &&
          isValidPassword &&
          isPasswordMatch &&
          agreedTnC &&
          !isLoading;

  SignupState copyWith({
    AsyncValue<User?>? signupValue,
    String? name,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
    bool? isObscurePassword,
    bool? isObscureConfirm,
    bool? agreedTnC,
  }) {
    return SignupState(
      signupValue: signupValue ?? this.signupValue,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isObscurePassword: isObscurePassword ?? this.isObscurePassword,
      isObscureConfirm: isObscureConfirm ?? this.isObscureConfirm,
      agreedTnC: agreedTnC ?? this.agreedTnC,
    );
  }
}

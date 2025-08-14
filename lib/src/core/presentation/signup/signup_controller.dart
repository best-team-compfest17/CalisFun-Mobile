import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'signup_state.dart';

final signupControllerProvider =
StateNotifierProvider<SignupController, SignupState>(
      (ref) => SignupController(),
);

class SignupController extends StateNotifier<SignupState> {
  SignupController() : super(const SignupState());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  void onNameChanged(String v) =>
      state = state.copyWith(name: v, signupValue: const AsyncData(null));
  void onEmailChanged(String v) =>
      state = state.copyWith(email: v, signupValue: const AsyncData(null));
  void onPhoneChanged(String v) =>
      state = state.copyWith(phone: v, signupValue: const AsyncData(null));
  void onPasswordChanged(String v) =>
      state = state.copyWith(password: v, signupValue: const AsyncData(null));
  void onConfirmChanged(String v) =>
      state = state.copyWith(confirmPassword: v, signupValue: const AsyncData(null));

  void toggleObscurePassword() =>
      state = state.copyWith(isObscurePassword: !state.isObscurePassword);
  void toggleObscureConfirm() =>
      state = state.copyWith(isObscureConfirm: !state.isObscureConfirm);
  void toggleAgreeTnC(bool? v) {
    state = state.copyWith(agreedTnC: v ?? false);
  }


  String? validateName(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Tidak boleh kosong';
    if (v.length < 2) return 'Minimal 2 karakter';
    return null;
  }

  String? validateEmail(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Tidak boleh kosong';
    final ok = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(v);
    if (!ok) return 'Email tidak valid';
    return null;
  }

  String? validatePhone(String? value) {
    final v = (value ?? '').replaceAll(' ', '');
    if (v.isEmpty) return 'Tidak boleh kosong';
    if (!RegExp(r'^[0-9]{9,15}$').hasMatch(v)) return 'Nomor tidak valid';
    return null;
  }

  String? validatePassword(String? value) {
    final v = value ?? '';
    if (v.isEmpty) return 'Tidak boleh kosong';
    if (v.length < 6) return 'Minimal 6 karakter';
    return null;
  }

  String? validateConfirm(String? value) {
    final v = value ?? '';
    if (v.isEmpty) return 'Tidak boleh kosong';
    if (v != passwordController.text) return 'Kata sandi tidak sama';
    return null;
  }

  Future<void> submit() async {
    final form = formKey.currentState;
    if (form == null) return;
    if (!form.validate()) return;
    if (!state.agreedTnC) return;

    state = state.copyWith(
      signupValue: const AsyncLoading(),
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      password: passwordController.text,
      confirmPassword: confirmController.text,
    );

    try {
      await Future<void>.delayed(const Duration(milliseconds: 800));
      state = state.copyWith(signupValue: const AsyncData(null));

    } catch (e, st) {
      state = state.copyWith(signupValue: AsyncError(e, st));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }
}

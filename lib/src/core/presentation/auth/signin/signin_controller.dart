import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'signin_state.dart';

final signinControllerProvider =
StateNotifierProvider<SigninController, SigninState>(
      (ref) => SigninController(),
);

class SigninController extends StateNotifier<SigninState> {
  SigninController() : super(const SigninState());

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onEmailChanged(String v) =>
      state = state.copyWith(email: v.trim(), loginValue: const AsyncData(null));

  void onPasswordChanged(String v) =>
      state = state.copyWith(password: v, loginValue: const AsyncData(null));

  void toggleObscure() =>
      state = state.copyWith(isObscure: !state.isObscure);

  String? validateEmail(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Tidak boleh kosong';
    final ok = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(v);
    if (!ok) return 'Email tidak valid';
    return null;
  }

  String? validatePassword(String? value) {
    final v = value ?? '';
    if (v.isEmpty) return 'Tidak boleh kosong';
    if (v.length < 6) return 'Minimal 6 karakter';
    return null;
  }

  Future<void> submit() async {
    final form = formKey.currentState;
    if (form == null) return;

    if (!form.validate()) return;

    state = state.copyWith(
      email: emailController.text.trim(),
      password: passwordController.text,
      loginValue: const AsyncLoading(),
    );

    try {
      await Future<void>.delayed(const Duration(milliseconds: 600));
      state = state.copyWith(loginValue: const AsyncData(null));
    } catch (e, st) {
      state = state.copyWith(loginValue: AsyncError(e, st));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

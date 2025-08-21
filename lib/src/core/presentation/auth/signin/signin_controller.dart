import 'dart:async';
import 'dart:developer'; // log
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../network/network.dart';
import 'signin_state.dart';
import 'package:calisfun/src/core/application/application.dart';
import 'package:calisfun/src/shared/preferences/preferences.dart';

final signinControllerProvider =
StateNotifierProvider<SigninController, SigninState>(
      (ref) => SigninController(ref),
);

class SigninController extends StateNotifier<SigninState> {
  SigninController(this._ref) : super(const SigninState());
  final Ref _ref;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onEmailChanged(String v) =>
      state = state.copyWith(email: v.trim(), signinValue: const AsyncData(null));

  void onPasswordChanged(String v) =>
      state = state.copyWith(password: v, signinValue: const AsyncData(null));

  void toggleObscure() => state = state.copyWith(isObscure: !state.isObscure);

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

  Future<void> tryAutoSignin() async {
    state = state.copyWith(signinValue: const AsyncLoading());
    try {
      final token = await _ref.read(userPreferenceProvider).getToken();
      if (token == null || token.isEmpty) {
        state = state.copyWith(signinValue: const AsyncData(null));
        return;
      }
      final svc = _ref.read(userServiceProvider);
      final res = await svc.meData(token);
      state = res.when(
        success: (user) {
          log('AUTO SIGNIN SUCCESS for ${user?.username ?? '-'}');
          return state.copyWith(signinValue: AsyncData(user));
        },
        failure: (err, st) {
          final msg = NetworkExceptions.getErrorMessage(err);
          log('AUTO SIGNIN FAILED: $msg');
          return state.copyWith(signinValue: AsyncError(err, st));
        },
      );
    } catch (e, st) {
      log('AUTO SIGNIN CRASH: $e');
      state = state.copyWith(signinValue: AsyncError(e, st));
    }
  }

  Future<void> submit() async {
    final form = formKey.currentState;
    if (form == null) return;
    if (!form.validate()) return;

    final email = emailController.text.trim();
    final password = passwordController.text;

    state = state.copyWith(
      email: email,
      password: password,
      signinValue: const AsyncLoading(),
    );

    try {
      final svc = _ref.read(userServiceProvider);
      final res = await svc.loginData(email: email, password: password);

      state = res.when(
        success: (user) {
          log('LOGIN SUCCESS for ${user?.username ?? '-'}');
          return state.copyWith(signinValue: AsyncData(user));
        },
        failure: (err, st) {
          final msg = NetworkExceptions.getErrorMessage(err);
          log('LOGIN FAILED: $msg');
          return state.copyWith(signinValue: AsyncError(err, st));
        },
      );
    } catch (e, st) {
      log('LOGIN CRASH: $e');
      state = state.copyWith(signinValue: AsyncError(e, st));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

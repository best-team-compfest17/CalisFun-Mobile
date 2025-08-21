// parent_profile_controller.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../network/network.dart';
import '../../../../shared/preferences/preferences.dart';
import '../../../application/application.dart';
import '../../../domain/domain.dart';
import 'parent_profile_state.dart';

final parentProfileControllerProvider =
StateNotifierProvider<ParentProfileController, ParentProfileState>(
      (ref) => ParentProfileController(ref)..loadProfile(),
);

class ParentProfileController extends StateNotifier<ParentProfileState> {
  ParentProfileController(this._ref) : super(const ParentProfileState());
  final Ref _ref;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  UserService get _userService => _ref.read(userServiceProvider);
  UserPreference get _userPref => _ref.read(userPreferenceProvider);

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> loadProfile() async {
    state = state.copyWith(profileValue: const AsyncLoading<User?>());

    try {
      final token = await _userPref.getToken();
      if (token == null || token.isEmpty) {
        state = state.copyWith(
          profileValue: AsyncError(
            const NetworkExceptions.badRequest(),
            StackTrace.current,
          ),
        );
        return;
      }

      final result = await _userService.meData(token);

      result.when(
        success: (user) {
          nameController.text = user?.username ?? 'adada';
          emailController.text = user?.email ?? '';
          phoneNumberController.text = user?.phoneNumber ?? '';
          state = state.copyWith(
            profileValue: AsyncData(user),
          );
        },
        failure: (error, stackTrace) {
          state = state.copyWith(
            profileValue: AsyncError(error, stackTrace),
          );
        },
      );
    } catch (e, stackTrace) {
      state = state.copyWith(
        profileValue: AsyncError(
          NetworkExceptions.getDioException(e),
          stackTrace,
        ),
      );
    }
  }

  void toggleEditMode() {
    state = state.copyWith(isEditMode: !state.isEditMode);
  }

  Future<void> updateProfile() async {
    if (!formKey.currentState!.validate()) return;

    state = state.copyWith(profileValue: const AsyncLoading<User?>());

    try {
      final token = await _userPref.getToken();
      if (token == null || token.isEmpty) {
        state = state.copyWith(
          profileValue: AsyncError(
            const NetworkExceptions.badRequest(),
            StackTrace.current,
          ),
        );
        return;
      }

      await Future.delayed(const Duration(seconds: 1));

      final updatedUser = User(
        id: state.profileValue.value?.id ?? '',
        username: nameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        role: state.profileValue.value?.role ?? 'parent',
        children: state.profileValue.value?.children ?? [],
      );

      state = state.copyWith(
        profileValue: AsyncData(updatedUser),
        isEditMode: false,
      );

    } catch (e, stackTrace) {
      state = state.copyWith(
        profileValue: AsyncError(
          NetworkExceptions.getDioException(e),
          stackTrace,
        ),
      );
    }
  }

  void cancelEdit() {
    final user = state.profileValue.value;
    nameController.text = user?.username ?? '';
    emailController.text = user?.email ?? '';
    phoneNumberController.text = user?.phoneNumber ?? '';

    state = state.copyWith(isEditMode: false);
  }
}
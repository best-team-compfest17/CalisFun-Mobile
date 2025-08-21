import 'package:calisfun/src/core/presentation/parent/home-parent/home_parent_controller.dart';
import 'package:calisfun/src/network/network.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/application.dart';
import 'child_profile_state.dart';

final childProfileControllerProvider =
StateNotifierProvider<ChildProfileController, ChildProfileState>((ref) {
  final userService = ref.read(userServiceProvider);
  return ChildProfileController(ref, userService);
});

class ChildProfileController extends StateNotifier<ChildProfileState> {
  final Ref ref;
  final UserService _userService;

  ChildProfileController(this.ref, this._userService)
      : super(const ChildProfileState());

  Future<void> deleteChildProfile(String childId) async {
    state = state.copyWith(loading: true, clearError: true);

    try {
      final result = await _userService.deleteChildProfile(childId: childId);

      result.when(
        success: (success) {
          if (success) {
            state = state.copyWith(
              loading: false,
              deleteSuccess: true,
            );
            ref.read(homeParentControllerProvider.notifier).load();
          } else {
            state = state.copyWith(
              loading: false,
              error: 'Gagal menghapus profil anak',
            );
          }
        },
        failure: (error, stackTrace) {
          state = state.copyWith(
            loading: false,
            error: error.toString(),
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }

  void resetState() {
    state = const ChildProfileState();
  }
}
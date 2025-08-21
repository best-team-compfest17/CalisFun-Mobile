import 'package:calisfun/src/network/network.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/preferences/preferences.dart';
import '../../../application/application.dart';
import '../../../domain/domain.dart';
import 'home_parent_state.dart';

final homeParentControllerProvider =
StateNotifierProvider<HomeParentController, HomeParentState>((ref) {
  final userService = ref.read(userServiceProvider);
  final userPref = ref.read(userPreferenceProvider);
  return HomeParentController(ref, userService, userPref)..load();
});

class HomeParentController extends StateNotifier<HomeParentState> {
  final Ref ref;
  final UserService _userService;
  final UserPreference _userPref;

  HomeParentController(this.ref, this._userService, this._userPref)
      : super(const HomeParentState());

  Future<void> load() async {
    state = state.copyWith(loading: true, clearError: true);

    try {
      final token = await _userPref.getToken();
      if (token == null || token.isEmpty) {
        state = state.copyWith(
          loading: false,
          error: 'Token tidak ditemukan. Silakan login ulang.',
        );
        return;
      }

      final meResult = await _userService.meData(token);
      meResult.when(
        success: (user) {
          final children = user?.children ?? const <Child>[];
          state = state.copyWith(
            user: user,
            children: children,
            loading: false,
          );
        },
        failure: (err, _) {
          state = state.copyWith(
            loading: false,
            error: err.toString(),
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

  Future<void> refresh() => load();
}
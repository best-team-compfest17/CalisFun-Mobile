import 'package:calisfun/src/network/network.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/preferences/preferences.dart';
import '../../../application/application.dart';
import '../../../domain/domain.dart';
import 'select_child_state.dart';

final selectedChildProvider = StateProvider<Child?>((_) => null);

final selectChildControllerProvider =
StateNotifierProvider<SelectChildController, SelectChildState>((ref) {
  final userService = ref.read(userServiceProvider);
  final userPref = ref.read(userPreferenceProvider);
  return SelectChildController(ref, userService, userPref)..load();
});

class SelectChildController extends StateNotifier<SelectChildState> {
  final Ref ref;
  final UserService _userService;
  final UserPreference _userPref;

  SelectChildController(this.ref, this._userService, this._userPref)
      : super(const SelectChildState());

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
          state = state.copyWith(children: children, loading: false);
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

  void select(Child child) {
    state = state.copyWith(selectedChildId: child.id, clearError: true);
    ref.read(selectedChildProvider.notifier).state = child;
  }

  Future<void> refresh() => load();
}

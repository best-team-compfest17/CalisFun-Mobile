import 'package:calisfun/src/network/network.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/leaderboard_service.dart';
import '../../../core.dart';
import 'leaderboard_state.dart';

final leaderboardControllerProvider =
StateNotifierProvider<LeaderboardController, LeaderboardState>((ref) {
  final svc = ref.read(leaderboardServiceProvider);
  return LeaderboardController(svc);
});

class LeaderboardController extends StateNotifier<LeaderboardState> {
  final LeaderboardService _service;
  String? _childId;

  LeaderboardController(this._service) : super(const LeaderboardState());

  Future<void> bootstrap({required String childId}) async {
    _childId = childId;
    await fetch();
  }

  Future<void> fetch() async {
    if (_childId == null || _childId!.isEmpty) return;
    state = state.copyWith(isLoading: true, error: null);

    final res = await _service.fetchLeaderboard(childId: _childId!);
    res.when(
      success: (payload) {
        state = state.copyWith(
          isLoading: false,
          users: payload.users,
          yourRank: payload.yourRank,
        );
      },
      failure: (err, _) {
        state = state.copyWith(isLoading: false, error: err.toString());
      },
    );
  }

  List<LeaderboardViewItem> get top3 {
    final u = state.users;
    final first = u.isNotEmpty ? u[0] : null;
    final second = u.length > 1 ? u[1] : null;
    final third = u.length > 2 ? u[2] : null;
    return [
      if (second != null) LeaderboardViewItem(rank: 2, user: second),
      if (first != null) LeaderboardViewItem(rank: 1, user: first),
      if (third != null) LeaderboardViewItem(rank: 3, user: third),
    ];
  }

  List<LeaderboardViewItem> get listAfterTop3 {
    final rest = state.users.length > 3 ? state.users.sublist(3) : <LeaderboardUser>[];
    return List.generate(rest.length, (i) => LeaderboardViewItem(rank: i + 4, user: rest[i]));
  }
}

class LeaderboardViewItem {
  final int rank;
  final LeaderboardUser user;
  LeaderboardViewItem({required this.rank, required this.user});
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../network/network.dart';
import '../../shared/preferences/preferences.dart';
import '../core.dart';


class LeaderboardPayload {
  final List<LeaderboardUser> users;
  final int? yourRank;
  const LeaderboardPayload({required this.users, this.yourRank});
}

class LeaderboardService {
  final LeaderboardRepository repository;
  final UserPreference userPreference;

  LeaderboardService({
    required this.repository,
    required this.userPreference,
  });

  Future<Result<LeaderboardPayload>> fetchLeaderboard({
    required String childId,
  }) async {
    try {
      final token = await userPreference.getToken();
      if (token == null || token.isEmpty) {
        return Result.failure(const NetworkExceptions.badRequest(), StackTrace.current);
      }

      final repoRes = await repository.getLeaderboard(token: token);
      return repoRes.when(
        success: (list) {
          final idx = list.indexWhere((u) => u.id == childId);
          final rank = idx >= 0 ? idx + 1 : null;
          return Result.success(LeaderboardPayload(users: list, yourRank: rank));
        },
        failure: (err, st) => Result.failure(err, st),
      );
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getDioException(e), st);
    }
  }
}

final leaderboardServiceProvider = Provider<LeaderboardService>((ref) {
  final repo = ref.read(leaderboardRepositoryProvider);
  final pref = ref.read(userPreferenceProvider);
  return LeaderboardService(repository: repo, userPreference: pref);
});

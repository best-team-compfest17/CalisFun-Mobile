part of 'data.dart';

class LeaderboardRepository {
  final DioClient _dioClient;
  LeaderboardRepository(this._dioClient);

  Future<Result<List<LeaderboardUser>>> getLeaderboard({String? token}) async {
    try {
      final res = await _dioClient.get(
        Endpoint.leaderboard,
        options: token == null ? null : Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final data = (res is Response) ? res.data : res;
      final users = LeaderboardConverter.fromList(data);
      users.sort((a, b) => b.xp.compareTo(a.xp));

      return Result.success(users);
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getDioException(e), st);
    }
  }
}

final leaderboardRepositoryProvider = Provider<LeaderboardRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return LeaderboardRepository(dioClient);
});


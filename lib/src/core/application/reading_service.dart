part of 'application.dart';

class ReadingService {
  final ReadingRepository readingRepository;
  final UserPreference userPreference;

  ReadingService({
    required this.readingRepository,
    required this.userPreference,
  });

  Future<Result<ReadingQuestion>> fetchWordForChild({
    required String childId,
    String category = 'word',
  }) async {
    try {
      final token = await userPreference.getToken();
      if (token == null || token.isEmpty) {
        return Result.failure(
          const NetworkExceptions.badRequest(),
          StackTrace.current,
        );
      }

      final repoRes = await readingRepository.getUserReadingWord(
        childId: childId,
        token: token,
        category: category,
      );

      return repoRes.when(
        success: (api) {
          final map = _extractPayloadMap(api);
          final base =
              (map is Map<String, dynamic>)
                  ? map
                  : map;

          final rw = ReadingQuestionConverter.fromJson(base);
          return Result.success(rw);
        },
        failure: (err, st) => Result.failure(err, st),
      );
    } catch (e, st) {
      return Result.failure(NetworkExceptions.badRequest(), st);
    }
  }

  Future<Result<bool>> submitProgress({
    required String childId,
    required String questionId,
  }) async {
    try {
      final token = await userPreference.getToken();
      if (token == null || token.isEmpty) {
        return Result.failure(const NetworkExceptions.badRequest(), StackTrace.current);
      }

      final res = await readingRepository.postReadingProgress(
        childId: childId,
        token: token,
        questionId: questionId,
      );

      return res.when(
        success: (_) => const Result.success(true),
        failure: (err, st) => Result.failure(err, st),
      );
    } catch (e, st) {
      return Result.failure(NetworkExceptions.badRequest(), st);
    }
  }
}

final readingServiceProvider = Provider<ReadingService>((ref) {
  final repo = ref.read(readingRepositoryProvider);
  final pref = ref.read(userPreferenceProvider);
  return ReadingService(readingRepository: repo, userPreference: pref);
});

part of 'application.dart';


extension WritingCategoryX on WritingCategory {
  String get value {
    switch (this) {
      case WritingCategory.word:
        return 'word';
      case WritingCategory.letter:
        return 'letter';
      case WritingCategory.number:
        return 'number';
    }
  }
}

class WritingService {
  final WritingRepository _repo;
  final Duration cacheTtl;
  final Map<String, _CacheEntry> _cache = {};

  WritingService(this._repo, {this.cacheTtl = const Duration(minutes: 2)});

  String _key(String childId, WritingCategory category) =>
      '$childId:${category.value}';

  bool _isFresh(String key) {
    final hit = _cache[key];
    if (hit == null) return false;
    return DateTime.now().isBefore(hit.expiredAt);
  }

  Future<Result<ApiResponse>> fetchByCategory({
    required String childId,
    required String token,
    required WritingCategory category,
    bool forceRefresh = false,
  }) async {
    final key = _key(childId, category);

    if (!forceRefresh && _isFresh(key)) {
      return Result.success(_cache[key]!.data);
    }

    try {
      Result<ApiResponse> res;

      switch (category) {
        case WritingCategory.word:
          res = await _repo.getUserWritingWord(
            childId: childId,
            token: token,
          );
          break;
        case WritingCategory.letter:
          res = await _repo.getUserWritingLetter(
            childId: childId,
            token: token,
          );
          break;
        case WritingCategory.number:
          res = await _repo.getUserWritingNumber(
            childId: childId,
            token: token,
          );
          break;
      }

      return res.when(
        success: (data) {
          final normalizedData = _normalizeWritingData(data, category);
          _cache[key] = _CacheEntry(
            data: normalizedData,
            expiredAt: DateTime.now().add(cacheTtl),
          );
          return Result.success(normalizedData);
        },
        failure: (e, st) => Result.failure(e, st),
      );
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getDioException(e), st);
    }
  }

  ApiResponse _normalizeWritingData(ApiResponse data, WritingCategory category) {
    final raw = data.data;
    if (raw is! Map<String, dynamic>) return data;

    final Map<String, dynamic> normalized = Map.from(raw);
    if (raw.containsKey('word') && !raw.containsKey('target')) {
      normalized['target'] = raw['word'];
    } else if (raw.containsKey('letter') && !raw.containsKey('target')) {
      normalized['target'] = raw['letter'];
    } else if (raw.containsKey('number') && !raw.containsKey('target')) {
      normalized['target'] = raw['number'];
    }

    return ApiResponse(
      status: data.status,
      message: data.message,
      data: normalized,
    );
  }

  Future<Result<ApiResponse>> fetchWords({
    required String childId,
    required String token,
    bool forceRefresh = false,
  }) =>
      fetchByCategory(
        childId: childId,
        token: token,
        category: WritingCategory.word,
        forceRefresh: forceRefresh,
      );

  Future<Result<ApiResponse>> fetchLetters({
    required String childId,
    required String token,
    bool forceRefresh = false,
  }) =>
      fetchByCategory(
        childId: childId,
        token: token,
        category: WritingCategory.letter,
        forceRefresh: forceRefresh,
      );

  Future<Result<ApiResponse>> fetchNumbers({
    required String childId,
    required String token,
    bool forceRefresh = false,
  }) =>
      fetchByCategory(
        childId: childId,
        token: token,
        category: WritingCategory.number,
        forceRefresh: forceRefresh,
      );

  Future<Result<ApiResponse>> postProgress({
    required String childId,
    required String token,
    required String questionId,
    WritingCategory? invalidateCategory,
  }) async {
    try {
      final res = await _repo.postWritingProgress(
        childId: childId,
        token: token,
        questionId: questionId,
      );
      if (invalidateCategory != null) {
        _cache.remove(_key(childId, invalidateCategory));
      } else {
        _cache.removeWhere((k, v) => k.startsWith('$childId:'));
      }

      return res;
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getDioException(e), st);
    }
  }
  void clearCache() => _cache.clear();
  void invalidateChild(String childId) =>
      _cache.removeWhere((k, v) => k.startsWith('$childId:'));
}

class _CacheEntry {
  final ApiResponse data;
  final DateTime expiredAt;
  _CacheEntry({required this.data, required this.expiredAt});
}

final writingServiceProvider = Provider<WritingService>((ref) {
  final repo = ref.watch(writingRepositoryProvider);
  return WritingService(repo);
});

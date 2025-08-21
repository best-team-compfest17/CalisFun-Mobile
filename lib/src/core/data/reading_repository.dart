part of 'data.dart';

class ReadingRepository {
  final DioClient _dioClient;
  ReadingRepository(this._dioClient);

  Map<String, dynamic> _asMap(dynamic res) {
    if (res == null) return <String, dynamic>{};

    if (res is Response) {
      final data = res.data;
      if (data is Map<String, dynamic>) return data;
      if (data is String && data.isNotEmpty) {
        return jsonDecode(data) as Map<String, dynamic>;
      }
      return <String, dynamic>{};
    }

    if (res is Map<String, dynamic>) return res;

    if (res is String && res.isNotEmpty) {
      return jsonDecode(res) as Map<String, dynamic>;
    }

    return <String, dynamic>{};
  }

  Future<Result<ApiResponse>> getUserReadingWord({
    required String childId,
    required String token,
    String category = 'word',
  }) async {
    try {
      final res = await _dioClient.get(
        '${Endpoint.getReading}/$childId',
        queryParameters: {'category': category},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final map = _asMap(res);
      return Result.success(ApiResponse.fromJson(map));
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getDioException(e), st);
    }
  }

  Future<Result<ApiResponse>> postReadingProgress({
    required String childId,
    required String token,
    required String questionId,
  }) async {
    try {
      final res = await _dioClient.post(
        '${Endpoint.readingProgress}/$childId',
        data: {'questionId': questionId},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final map = _asMap(res);
      return Result.success(ApiResponse.fromJson(map));
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getDioException(e), st);
    }
  }
}

final readingRepositoryProvider = Provider<ReadingRepository>((ref) {
  final dio = ref.read(dioClientProvider);
  return ReadingRepository(dio);
});

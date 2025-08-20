part of 'data.dart';

class UserRepository {
  final DioClient _dioClient;

  UserRepository(this._dioClient);

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

  Future<Result<ApiResponse>> register({
    required String username,
    required String email,
    required String phoneNumber,
    required String password,
    String role = 'parent',
  }) async {
    try {
      final res = await _dioClient.post(
        Endpoint.register,
        data: {
          'username': username,
          'email': email,
          'phone_number': phoneNumber,
          'password': password,
          'role': role,
        },
      );

      final map = _asMap(res);
      return Result.success(ApiResponse.fromJson(map));
    } catch (e, stackTrace) {
      return Result.failure(NetworkExceptions.getDioException(e), stackTrace);
    }
  }

  Future<Result<ApiResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _dioClient.post(
        Endpoint.login,
        data: {'email': email, 'password': password},
      );

      final map = _asMap(res);
      log('LOGIN RAW MAP: $map');

      return Result.success(ApiResponse.fromJson(map));
    } catch (e, stackTrace) {
      log('LOGIN REPOSITORY ERROR: $e');
      return Result.failure(NetworkExceptions.getDioException(e), stackTrace);
    }
  }

  Future<Result<ApiResponse>> me(String? token) async {
    try {
      await _dioClient.useToken(token);
      final res = await _dioClient.get(Endpoint.getUserProfile);

      final map = _asMap(res);
      return Result.success(ApiResponse.fromJson(map));
    } catch (e, stackTrace) {
      return Result.failure(NetworkExceptions.getDioException(e), stackTrace);
    }
  }
}


final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dio = ref.read(dioClientProvider);
  return UserRepository(dio);
});

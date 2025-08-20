part of 'data.dart';

class UserRepository {
  final DioClient _dioClient;

  UserRepository(this._dioClient);

  Future<Result<ApiResponse>> register({
    required String username,
    required String email,
    required String phoneNumber,
    required String password,
    String role = 'parent',
  }) async {
    try {
      final response = await _dioClient.post(
        Endpoint.register, // '/auth/register'
        data: {
          'username': username,
          'email': email,
          'phone_number': phoneNumber,
          'password': password,
          'role': role,
        },
      );
      return Result.success(ApiResponse.fromJson(response));
    } catch (e, stackTrace) {
      return Result.failure(NetworkExceptions.getDioException(e), stackTrace);
    }
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dio = ref.read(dioClientProvider);
  return UserRepository(dio);
});

part of 'application.dart';

final userServiceProvider = Provider<UserService>((ref) {
  final repo = ref.read(userRepositoryProvider);
  return UserService(userRepository: repo);
});

class UserService {
  final UserRepository userRepository;

  UserService({required this.userRepository});

  Future<Result<User?>> registerData({
    required String username,
    required String email,
    required String phoneNumber,
    required String password,
    String role = 'parent',
  }) async {
    final result = await userRepository.register(
      username: username,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      role: role,
    );

    return result.when(
      success: (api) async {
        final map = _extractPayloadMap(api);
        final payload = (map['data'] is Map<String, dynamic>)
            ? map['data'] as Map<String, dynamic>
            : map;
        final token = payload['token'] as String?;
        if (token != null && token.isNotEmpty) {
          log('REGISTER TOKEN: $token');
        }
        final userJson = payload['user'];
        if (userJson is Map<String, dynamic>) {
          final user = UserConverter.fromJson(userJson);
          return Result.success(user);
        }

        return Result.failure(const NetworkExceptions.badRequest(), StackTrace.current);
      },
      failure: (error, stackTrace) => Result.failure(error, stackTrace),
    );
  }
}

Map<String, dynamic> _extractPayloadMap(dynamic api) {
  try {
    final d = (api as dynamic).data;
    if (d is Map<String, dynamic>) return d;
  } catch (_) {}

  try {
    final tj = (api as dynamic).toJson();
    if (tj is Map<String, dynamic>) return tj;
  } catch (_) {}

  if (api is Map<String, dynamic>) return api;

  return const <String, dynamic>{};
}

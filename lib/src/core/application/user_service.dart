part of 'application.dart';

class UserService {
  final UserRepository userRepository;
  final UserPreference userPreference;

  UserService({required this.userRepository, required this.userPreference});

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

        // Jika register juga mengembalikan token, simpan aman
        final token = payload['token'] as String?;
        if (token != null && token.isNotEmpty) {
          // Hindari log token raw
          log('REGISTER TOKEN: ${_maskToken(token)}');
          await userPreference.saveToken(token);
        }

        // Jika backend mengembalikan user di payload
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

  Future<Result<User?>> loginData({
    required String email,
    required String password,
  }) async {
    final result = await userRepository.login(
      email: email,
      password: password,
    );

    return result.when(
      success: (api) async {
        try {
          log('LOGIN API RESPONSE TYPE: ${api.runtimeType}');
          log('LOGIN API DATA: ${api.data}');

          Map<String, dynamic> responseMap;

          if (api.data is Map<String, dynamic>) {
            responseMap = api.data as Map<String, dynamic>;
          } else {
            responseMap = _extractPayloadMap(api);
          }

          log('RESPONSE MAP: $responseMap');

          final token = responseMap['token'] as String?;
          if (token == null || token.isEmpty) {
            log('NO TOKEN FOUND IN: $responseMap');
            return Result.failure(const NetworkExceptions.badRequest(), StackTrace.current);
          }

          // Simpan token aman & hindari log raw
          log('TOKEN RECEIVED: ${_maskToken(token)}');
          await userPreference.saveToken(token);

          // Lanjut ambil profil; UserRepository.me() akan set Authorization header
          return await meData(token);
        } catch (e, stackTrace) {
          log('ERROR IN LOGIN DATA: $e');
          log('STACKTRACE: $stackTrace');
          return Result.failure(NetworkExceptions.badRequest(), stackTrace);
        }
      },
      failure: (error, stackTrace) => Result.failure(error, stackTrace),
    );
  }

  Future<Result<User?>> meData(String? token) async {
    try {
      final result = await userRepository.me(token);
      return result.when(
        success: (apiResponse) {
          try {
            final map = _extractPayloadMap(apiResponse);
            log('ME RESPONSE: $map');

            if (map is Map<String, dynamic>) {
              final user = UserConverter.fromJson(map);
              return Result.success(user);
            }

            log('INVALID USER DATA FORMAT: $map');
            return Result.failure(const NetworkExceptions.badRequest(), StackTrace.current);
          } catch (e, stackTrace) {
            log('ERROR PARSING ME RESPONSE: $e');
            return Result.failure(NetworkExceptions.badRequest(), stackTrace);
          }
        },
        failure: (error, stackTrace) {
          log('ME CALL FAILED: $error');
          return Result.failure(error, stackTrace);
        },
      );
    } catch (e, stackTrace) {
      log('ME DATA CRASH: $e');
      return Result.failure(NetworkExceptions.badRequest(), stackTrace);
    }
  }
}

Map<String, dynamic> _extractPayloadMap(dynamic api) {
  log('EXTRACTING PAYLOAD FROM: ${api.runtimeType}');

  if (api is ApiResponse) {
    log('API IS ApiResponse, data: ${api.data}');
    if (api.data != null) {
      if (api.data is Map<String, dynamic>) {
        return api.data as Map<String, dynamic>;
      }
      try {
        final converted = Map<String, dynamic>.from(api.data as dynamic);
        return converted;
      } catch (e) {
        log('Cannot convert data to Map: $e');
      }
    }
  }

  try {
    if (api is ApiResponse) {
      final rawResponse = (api as dynamic).rawResponse;
      if (rawResponse != null && rawResponse.data is Map<String, dynamic>) {
        return rawResponse.data as Map<String, dynamic>;
      }
    }
  } catch (e) {
    log('Error accessing rawResponse: $e');
  }

  if (api is Map<String, dynamic>) {
    return api;
  }

  log('RETURNING EMPTY MAP');
  return const <String, dynamic>{};
}

// Masker sederhana agar token tidak tampil full di log
String _maskToken(String token) {
  if (token.length <= 10) return '***';
  return '${token.substring(0, 4)}...${token.substring(token.length - 4)}';
}

final userServiceProvider = Provider<UserService>((ref) {
  final repo = ref.read(userRepositoryProvider);
  final userPreference = ref.read(userPreferenceProvider);
  return UserService(userRepository: repo, userPreference: userPreference);
});

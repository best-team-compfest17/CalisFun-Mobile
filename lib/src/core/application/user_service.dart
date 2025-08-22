part of 'application.dart';

class UserService {
  final UserRepository userRepository;
  final UserPreference userPreference;

  UserService({required this.userRepository, required this.userPreference});

  String _difficultyToString(Difficulty d) => switch (d) {
    Difficulty.easy => 'easy',
    Difficulty.medium => 'medium',
    Difficulty.hard => 'hard',
  };

  Difficulty? _nextDifficulty(Difficulty d) => switch (d) {
    Difficulty.easy => Difficulty.medium,
    Difficulty.medium => Difficulty.hard,
    Difficulty.hard => null,
  };

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
          log('REGISTER TOKEN: ${_maskToken(token)}');
          await userPreference.saveToken(token);
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
          log('TOKEN RECEIVED: ${_maskToken(token)}');
          await userPreference.saveToken(token);
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

  Future<Result<Child?>> createChildProfile({
    required String name,
    File? imageFile,
  }) async {
    try {
      final token = await userPreference.getToken();
      if (token == null || token.isEmpty) {
        return Result.failure(const NetworkExceptions.badRequest(), StackTrace.current);
      }

      final repoRes = await userRepository.createChildProfile(
        name: name,
        token: token,
        avatarFile: imageFile,
      );

      return repoRes.when(
        success: (api) {
          final map = _extractPayloadMap(api);

          final childJson = (map['child'] is Map<String, dynamic>)
              ? map['child'] as Map<String, dynamic>
              : map;
          final child = ChildConverter.fromJson(childJson);
          return Result.success(child);
        },
        failure: (err, st) => Result.failure(err, st),
      );
    } catch (e, st) {
      return Result.failure(NetworkExceptions.badRequest(), st);
    }
  }

  Future<Result<bool>> deleteChildProfile({
    required String childId,
  }) async {
    try {
      final token = await userPreference.getToken();
      if (token == null || token.isEmpty) {
        return Result.failure(const NetworkExceptions.badRequest(), StackTrace.current);
      }

      final result = await userRepository.deleteChildProfile(
        childId: childId,
        token: token,
      );

      return result.when(
        success: (apiResponse) {
          return Result.success(true);
        },
        failure: (error, stackTrace) => Result.failure(error, stackTrace),
      );
    } catch (e, stackTrace) {
      log('DELETE CHILD PROFILE ERROR: $e');
      return Result.failure(NetworkExceptions.badRequest(), stackTrace);
    }
  }

  Future<Result<Child>> fetchChildById(String id) async {
    try {
      final token = await userPreference.getToken();
      if (token == null || token.isEmpty) {
        return Result.failure(const NetworkExceptions.badRequest(), StackTrace.current);
      }

      final res = await userRepository.getChildById(id: id, token: token);
      return res.when(
        success: (api) {
          final map = _extractPayloadMap(api);
          final json = (map['child'] is Map<String, dynamic>)
              ? map['child'] as Map<String, dynamic>
              : map;

          final child = ChildConverter.fromJson(json);
          return Result.success(child);
        },
        failure: (err, st) => Result.failure(err, st),
      );
    } catch (e, st) {
      return Result.failure(NetworkExceptions.badRequest(), st);
    }
  }

  Future<Result<bool>> updateCountingDifficulty({
    required String childId,
    required Difficulty difficulty,
  }) async {
    try {
      final token = await userPreference.getToken();
      if (token == null || token.isEmpty) {
        return Result.failure(const NetworkExceptions.badRequest(), StackTrace.current);
      }

      final res = await userRepository.updateCountingDifficulty(
        childId: childId,
        token: token,
        difficulty: _difficultyToString(difficulty),
      );

      return res.when(
        success: (_) => const Result.success(true),
        failure: (err, st) => Result.failure(err, st),
      );
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getDioException(e), st);
    }
  }

  Future<Result<bool>> promoteCountingDifficultyIfEligible({
    required String childId,
    required Difficulty currentDifficulty,
    required int correct,
    required int total,
  }) async {
    try {
      if (total <= 0 || correct < 7) {
        return const Result.success(false);
      }
      final next = _nextDifficulty(currentDifficulty);
      if (next == null) {
        return const Result.success(false);
      }
      return await updateCountingDifficulty(childId: childId, difficulty: next);
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getDioException(e), st);
    }
  }

  Future<Result<bool>> logout() async {
    try {
      final token = await userPreference.getToken();
      if (token == null || token.isEmpty) {
        return Result.failure(const NetworkExceptions.badRequest(), StackTrace.current);
      }

      final res = await userRepository.logout(token);
      return res.when(
        success: (_) async {
          await userPreference.clearAllAuth();
          return const Result.success(true);
        },
        failure: (err, st) => Result.failure(err, st),
      );
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getDioException(e), st);
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



String _maskToken(String token) {
  if (token.length <= 10) return '***';
  return '${token.substring(0, 4)}...${token.substring(token.length - 4)}';
}

final userServiceProvider = Provider<UserService>((ref) {
  final repo = ref.read(userRepositoryProvider);
  final userPreference = ref.read(userPreferenceProvider);
  return UserService(userRepository: repo, userPreference: userPreference);
});

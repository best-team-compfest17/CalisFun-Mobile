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

      final safe = Map<String, dynamic>.from(map);
      final tok = safe['token'];
      if (tok is String && tok.isNotEmpty) {
        safe['token'] = _maskToken(tok);
      }
      log('LOGIN RAW MAP (safe): $safe');

      return Result.success(ApiResponse.fromJson(map));
    } catch (e, stackTrace) {
      log('LOGIN REPOSITORY ERROR: $e');
      return Result.failure(NetworkExceptions.getDioException(e), stackTrace);
    }
  }

  Future<Result<ApiResponse>> me(String? token) async {
    try {
      if (token == null || token.isEmpty) {
        return Result.failure(
          const NetworkExceptions.badRequest(),
          StackTrace.current,
        );
      }

      await _dioClient.useToken(token);
      final res = await _dioClient.get(Endpoint.getUserProfile);

      final map = _asMap(res);
      return Result.success(ApiResponse.fromJson(map));
    } catch (e, stackTrace) {
      return Result.failure(NetworkExceptions.getDioException(e), stackTrace);
    }
  }

  Future<Result<ApiResponse>> deleteChildProfile({
    required String childId,
    required String token,
  }) async {
    try {
      final res = await _dioClient.delete(
        '${Endpoint.deleteChildProfile}/$childId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final map = _asMap(res);
      return Result.success(ApiResponse.fromJson(map));
    } catch (e, stackTrace) {
      return Result.failure(NetworkExceptions.getDioException(e), stackTrace);
    }
  }

  Future<Result<ApiResponse>> createChildProfile({
    required String name,
    required String token,
    File? avatarFile,
  }) async {
    try {
      final form = FormData.fromMap({
        'name': name,
        if (avatarFile != null)
          'avatar': await MultipartFile.fromFile(
            avatarFile.path,
            filename: p.basename(avatarFile.path),
          ),
      });

      form.fields.add(MapEntry('name', name)); // key default yang kita pakai
      if (avatarFile != null) {
        form.files.add(MapEntry(
          'avatar',
          await MultipartFile.fromFile(avatarFile.path, filename: p.basename(avatarFile.path)),
        ));
      }

      for (final f in form.fields) {
        log('[multipart field] ${f.key}=${f.value}');
      }
      for (final f in form.files) {
        log('[multipart file] ${f.key} -> ${f.value.filename}');
      }


      final res = await _dioClient.post(
        Endpoint.createChildProfile,
        data: form,
        options: Options(
          contentType: Headers.multipartFormDataContentType,
          headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
        ),
      );

      final map = _asMap(res);
      return Result.success(ApiResponse.fromJson(map));
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getDioException(e), st);
    }
  }

  Future<Result<ApiResponse>> getChildById({
    required String id,
    required String token,
  }) async {
    try {
      final res = await _dioClient.get(
        '${Endpoint.getChildOne}/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final map = _asMap(res);
      return Result.success(ApiResponse.fromJson(map));
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getDioException(e), st);
    }
  }


  String _maskToken(String token) {
    if (token.length <= 10) return '***';
    return '${token.substring(0, 4)}...${token.substring(token.length - 4)}';
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dio = ref.read(dioClientProvider);
  return UserRepository(dio);
});

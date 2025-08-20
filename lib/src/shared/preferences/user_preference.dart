import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'preferences.dart';

class UserPreferenceKeys {
  static const accessToken  = 'auth_access_token';
  static const refreshToken = 'auth_refresh_token'; // opsional
  static const userId       = 'user_id';            // opsional
  static const email        = 'user_email';         // opsional
  static const role         = 'user_role';          // opsional
}

class UserPreference {
  UserPreference(this._store);
  final KeyValueStore _store;

  // --- JWT ---
  Future<void> saveToken(String token) =>
      _store.writeString(UserPreferenceKeys.accessToken, token);

  Future<String?> getToken() =>
      _store.readString(UserPreferenceKeys.accessToken);

  Future<void> removeToken() =>
      _store.remove(UserPreferenceKeys.accessToken);

  // --- Refresh token (jika ada) ---
  Future<void> saveRefreshToken(String token) =>
      _store.writeString(UserPreferenceKeys.refreshToken, token);

  Future<String?> getRefreshToken() =>
      _store.readString(UserPreferenceKeys.refreshToken);

  Future<void> removeRefreshToken() =>
      _store.remove(UserPreferenceKeys.refreshToken);

  // --- Ringkasan user (opsional) ---
  Future<void> saveUser({String? id, String? email, String? role}) async {
    if (id != null)    await _store.writeString(UserPreferenceKeys.userId, id);
    if (email != null) await _store.writeString(UserPreferenceKeys.email, email);
    if (role != null)  await _store.writeString(UserPreferenceKeys.role, role);
  }

  Future<String?> getUserId() => _store.readString(UserPreferenceKeys.userId);
  Future<String?> getEmail()  => _store.readString(UserPreferenceKeys.email);
  Future<String?> getRole()   => _store.readString(UserPreferenceKeys.role);

  Future<void> clearUser() async {
    await _store.remove(UserPreferenceKeys.userId);
    await _store.remove(UserPreferenceKeys.email);
    await _store.remove(UserPreferenceKeys.role);
  }

  Future<void> clearAllAuth() async {
    await removeToken();
    await removeRefreshToken();
    await clearUser();
  }
}

final userPreferenceProvider = Provider<UserPreference>((ref) {
  return UserPreference(ref.read(keyValueStoreProvider));
});

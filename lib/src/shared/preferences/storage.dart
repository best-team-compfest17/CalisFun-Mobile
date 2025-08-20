import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Kontrak sederhana untuk key–value
abstract class KeyValueStore {
  Future<void> writeString(String key, String value);
  Future<String?> readString(String key);
  Future<void> writeBool(String key, bool value);
  Future<bool?> readBool(String key);
  Future<void> remove(String key);
  Future<void> clear();
}

/// Implementasi aman untuk ANDROID (FlutterSecureStorage)
class SecureStore implements KeyValueStore {
  SecureStore(this._sec);

  final FlutterSecureStorage _sec;

  // Opsi Android default (tanpa parameter yang bikin error)
  static final AndroidOptions _a = AndroidOptions();

  @override
  Future<void> writeString(String key, String value) =>
      _sec.write(key: key, value: value, aOptions: _a);

  @override
  Future<String?> readString(String key) =>
      _sec.read(key: key, aOptions: _a);

  @override
  Future<void> writeBool(String key, bool value) =>
      writeString(key, value ? '1' : '0');

  @override
  Future<bool?> readBool(String key) async {
    final v = await readString(key);
    if (v == null) return null;
    return v == '1';
  }

  @override
  Future<void> remove(String key) =>
      _sec.delete(key: key, aOptions: _a);

  @override
  Future<void> clear() =>
      _sec.deleteAll(aOptions: _a);
}

// Provider untuk diinject
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final keyValueStoreProvider = Provider<KeyValueStore>((ref) {
  final sec = ref.read(secureStorageProvider);
  return SecureStore(sec);
});

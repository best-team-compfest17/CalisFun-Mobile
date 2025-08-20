import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'preferences.dart';

class IntroPreferenceKeys {
  static const hasSeenIntro = 'has_seen_intro_v1';
}

class IntroPreference {
  IntroPreference(this._store);
  final KeyValueStore _store;

  Future<void> setHasSeenIntro(bool value) =>
      _store.writeBool(IntroPreferenceKeys.hasSeenIntro, value);

  Future<bool> getHasSeenIntro() async =>
      (await _store.readBool(IntroPreferenceKeys.hasSeenIntro)) ?? false;

  Future<void> reset() =>
      _store.remove(IntroPreferenceKeys.hasSeenIntro);
}

final introPreferenceProvider = Provider<IntroPreference>((ref) {
  return IntroPreference(ref.read(keyValueStoreProvider));
});

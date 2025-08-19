import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'learn_spell_state.dart';

/// Kamus nama huruf (Indonesia) -> huruf
const Map<String, String> _idLetterMap = {
  'a': 'A', 'be': 'B', 'ce': 'C', 'de': 'D', 'e': 'E',
  'ef': 'F', 'ge': 'G', 'ha': 'H', 'i': 'I', 'je': 'J',
  'ka': 'K', 'el': 'L', 'em': 'M', 'en': 'N', 'o': 'O',
  'pe': 'P', 'ki': 'Q', 'er': 'R', 'es': 'S', 'te': 'T',
  'u': 'U', 've': 'V', 'we': 'W', 'eks': 'X', 'ye': 'Y', 'zet': 'Z',
};

/// Alias/salah-dengar umum
const Map<String, String> _idLetterAliases = {
  'va': 've',   // V
  'wa': 'we',   // W
  'zed': 'zet', // Z
};

String _cleanupToken(String s) =>
    s.trim().toLowerCase().replaceAll(RegExp(r'[^a-z]'), '');

/// Konversi 1 token hasil STT -> huruf
String _tokenToLetter(String token) {
  final t = _cleanupToken(token);
  if (t.isEmpty) return '';

  if (_idLetterMap.containsKey(t)) return _idLetterMap[t]!;
  if (_idLetterAliases.containsKey(t)) {
    final canon = _idLetterAliases[t]!;
    if (_idLetterMap.containsKey(canon)) return _idLetterMap[canon]!;
  }

  // fallback: langsung huruf
  if (t.length == 1 && RegExp(r'^[a-z]$').hasMatch(t)) {
    return t.toUpperCase();
  }
  return '';
}

final speechProvider =
NotifierProvider<SpeechController, SpeechState>(() => SpeechController());

class SpeechController extends Notifier<SpeechState> {
  final stt.SpeechToText _speech = stt.SpeechToText();

  @override
  SpeechState build() => const SpeechState();

  Future<void> init() async {
    final available = await _speech.initialize(
      onStatus: (s) => state = state.copyWith(status: s),
      onError: (e) =>
      state = state.copyWith(error: e.errorMsg, listening: false),
    );
    state = state.copyWith(available: available);
  }

  Future<void> start({String localeId = 'id_ID'}) async {
    if (!state.available) {
      await init();
      if (!state.available) return;
    }
    state = state.copyWith(words: '', listening: true, error: null);
    await _speech.listen(
      onResult: (result) {
        state = state.copyWith(
          words: result.recognizedWords,
          confidence: result.hasConfidenceRating ? (result.confidence ?? 0.0) : 0.0,
        );
      },
      localeId: localeId,
      listenMode: stt.ListenMode.confirmation,
      partialResults: true,
      cancelOnError: true,
    );
  }

  /// Mode khusus huruf tunggal
  Future<void> startForLetter({String localeId = 'id_ID'}) async {
    if (!state.available) {
      await init();
      if (!state.available) return;
    }
    state = state.copyWith(words: '', listening: true, error: null);
    await _speech.listen(
      onResult: (result) async {
        state = state.copyWith(
          words: result.recognizedWords,
          confidence: result.hasConfidenceRating ? (result.confidence ?? 0.0) : 0.0,
        );
        if (result.finalResult) {
          await _speech.stop();
          state = state.copyWith(listening: false);
        }
      },
      localeId: localeId,
      listenMode: stt.ListenMode.confirmation,
      partialResults: true,
      cancelOnError: true,
      listenFor: const Duration(seconds: 5),
      pauseFor: const Duration(milliseconds: 1200),
    );
  }

  Future<void> stop() async {
    await _speech.stop();
    state = state.copyWith(listening: false);
  }

  Future<void> cancel() async {
    await _speech.cancel();
    state = state.copyWith(listening: false, words: '');
  }

  Future<void> toggle({String localeId = 'id_ID'}) async {
    if (state.listening) {
      await stop();
    } else {
      await start(localeId: localeId);
    }
  }

  /// Cek cocok kata penuh
  bool isMatch(String target) {
    String norm(String s) =>
        s.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9 ]'), '');
    return norm(state.words) == norm(target);
  }

  /// Cek cocok huruf tunggal
  bool matchesLetter(String target) {
    final recognized = state.words;
    if (recognized.trim().isEmpty) return false;

    final tokens = recognized
        .toLowerCase()
        .replaceAll(RegExp(r'[,.;:]+'), ' ')
        .split(RegExp(r'\s+'))
        .where((t) => t.isNotEmpty)
        .toList();

    for (var i = tokens.length - 1; i >= 0; i--) {
      final letter = _tokenToLetter(tokens[i]);
      if (letter.isEmpty) continue;
      if (letter.toUpperCase() == target.trim().toUpperCase()) return true;
    }

    final fallback = _tokenToLetter(recognized);
    return fallback.toUpperCase() == target.trim().toUpperCase();
  }
}

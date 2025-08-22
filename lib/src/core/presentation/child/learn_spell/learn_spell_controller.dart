// learn_spell_controller.dart
import 'package:calisfun/src/network/network.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../../core.dart';
import 'learn_spell_state.dart';


final speechProvider =
NotifierProvider<SpeechController, SpeechState>(() => SpeechController());

enum SpellCheckResult { incorrect, success, failed }

class SpeechController extends Notifier<SpeechState> {
  final stt.SpeechToText _speech = stt.SpeechToText();

  @override
  SpeechState build() => const SpeechState();

  Future<void> init() async {
    final available = await _speech.initialize(
      onStatus: (s) => state = state.copyWith(status: s),
      onError: (e) => state = state.copyWith(error: e.errorMsg, listening: false),
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
      onResult: (result) async {
        state = state.copyWith(
          words: result.recognizedWords,
          confidence: result.hasConfidenceRating ? (result.confidence) : 0.0,
        );
        if (result.finalResult) {
          await _speech.stop();
          state = state.copyWith(listening: false);
        }
      },
      localeId: localeId,
      listenOptions: stt.SpeechListenOptions(
        listenMode: stt.ListenMode.dictation,
        partialResults: true,
        cancelOnError: true,
      ),
      listenFor: const Duration(seconds: 8),
      pauseFor: const Duration(milliseconds: 1500),
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

  bool isMatch(String target) {
    String norm(String s) =>
        s.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9 ]'), '');
    return norm(state.words) == norm(target);
  }

  Future<SpellCheckResult> checkAndSubmitProgress({
    required String childId,
    required String questionId,
    required String targetWord,
  }) async {
    if (!isMatch(targetWord)) {
      return SpellCheckResult.incorrect;
    }

    final svc = ref.read(readingServiceProvider);
    final res = await svc.submitProgress(
      childId: childId,
      questionId: questionId,
    );

    return res.when(
      success: (_) => SpellCheckResult.success,
      failure: (_, __) => SpellCheckResult.failed,
    );
  }
}

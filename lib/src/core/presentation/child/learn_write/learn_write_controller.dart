import 'package:calisfun/src/network/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart' as ml;

import '../../../../constants/constants.dart';
import '../../../../shared/preferences/preferences.dart';
import '../../../core.dart';
import 'learn_write_state.dart';

final authTokenFutureProvider = FutureProvider<String?>((ref) async {
  final pref = ref.watch(userPreferenceProvider);
  return await pref.getToken();
});




final learnWriteProvider = StateNotifierProvider.family<LearnWriteController, LearnWriteState, ({String childId, WritingCategory category})>((ref, params) {
  final svc = ref.watch(writingServiceProvider);
  final c = LearnWriteController(ref, svc, params.childId, params.category);
  ref.onDispose(() => c.dispose());
  return c;
});

class LearnWriteController extends StateNotifier<LearnWriteState> {
  LearnWriteController(this._ref, this._service, String childId, WritingCategory category)
      : super(LearnWriteState(childId: childId, category: category)) {
    _initModel();
    _bootstrap();
  }

  final Ref _ref;
  final WritingService _service;

  final _modelManager = ml.DigitalInkRecognizerModelManager();
  ml.DigitalInkRecognizer? _recognizer;
  static const String _languageCode = 'en-US';

  Future<void> _initModel() async {
    try {
      final downloaded = await _modelManager.isModelDownloaded(_languageCode);
      if (!downloaded) {
        state = state.copyWith(status: 'Mengunduh model…');
        await _modelManager.downloadModel(_languageCode);
      }
      _recognizer = ml.DigitalInkRecognizer(languageCode: _languageCode);
      state = state.copyWith(modelReady: true, status: 'Model siap');
    } catch (e) {
      state = state.copyWith(status: 'Gagal memuat model: $e');
    }
  }

  Future<void> _bootstrap() async {
    try {
      await _loadNextQuestion();
    } catch (e) {
      state = state.copyWith(
        status: 'Model siap',
        lastResult: 'Gagal memuat soal: $e',
      );
    }
  }

  Future<void> _loadNextQuestion() async {
    final token = await _ref.read(authTokenFutureProvider.future);
    if (token == null) {
      state = state.copyWith(status: 'Token kosong / belum login');
      return;
    }

    state = state.copyWith(status: 'Memuat soal…', loading: true);

    final res = await _service.fetchByCategory(
      childId: state.childId,
      token: token,
      category: state.category,
      forceRefresh: true,
    );

    res.when(
      success: (api) {
        final raw = api.data;
        final m = (raw is Map)
            ? Map<String, dynamic>.from(raw as Map)
            : <String, dynamic>{};

        final qid = m['_id']?.toString();

        final target = m['target']?.toString() ?? '';

        final lvl = (m['level'] is num) ? (m['level'] as num).toInt() : null;

        if (qid == null || target.isEmpty) {
          state = state.copyWith(
            status: 'Soal tidak tersedia',
            lastResult: 'Tidak ada soal aktif untuk kategori ini.',
            loading: false,
          );
          return;
        }

        state = state.copyWith(
          status: 'Model siap',
          questionId: qid,
          target: target,
          level: lvl,
          loading: false,
          strokes: const [],
          currentStroke: null,
          lastResult: null,
        );
      },
      failure: (e, _) {
        state = state.copyWith(
          status: 'Model siap',
          lastResult: 'Gagal memuat soal: ${e.toString()}',
          loading: false,
        );
      },
    );
  }

  void startStroke(Offset p) {
    final t = DateTime.now().millisecondsSinceEpoch;
    final s = ml.Stroke()..points = [ml.StrokePoint(x: p.dx, y: p.dy, t: t)];
    state = state.copyWith(currentStroke: s, lastResult: null);
  }

  static const double _minDelta = 1.5;

  void updateStroke(Offset p) {
    final cur = state.currentStroke;
    if (cur == null) return;
    cur.points = cur.points ?? <ml.StrokePoint>[];
    final last = cur.points.isNotEmpty ? cur.points.last : null;
    if (last != null) {
      final dx = p.dx - last.x, dy = p.dy - last.y;
      if ((dx * dx + dy * dy) < (_minDelta * _minDelta)) return;
    }
    cur.points.add(ml.StrokePoint(x: p.dx, y: p.dy, t: DateTime.now().millisecondsSinceEpoch));
    state = state.copyWith(currentStroke: cur);
  }

  void endStroke() {
    final cur = state.currentStroke;
    if (cur == null) return;
    if (cur.points.isEmpty) {
      state = state.copyWith(currentStroke: null);
      return;
    }
    state = state.copyWith(strokes: [...state.strokes, cur], currentStroke: null);
  }

  void undo() {
    if (state.currentStroke != null) {
      state = state.copyWith(currentStroke: null);
    } else if (state.strokes.isNotEmpty) {
      final list = [...state.strokes]..removeLast();
      state = state.copyWith(strokes: list);
    }
  }

  Future<void> check() async {
    if (!state.modelReady || _recognizer == null) return;

    final all = [
      ...state.strokes,
      if (state.currentStroke != null) state.currentStroke!,
    ];
    if (all.isEmpty) {
      state = state.copyWith(lastResult: 'Tulis dulu di papan 🙂');
      return;
    }
    if (state.questionId == null || state.target.isEmpty) {
      state = state.copyWith(lastResult: 'Soal belum siap. Coba lagi.');
      return;
    }

    state = state.copyWith(status: 'Mengenali…');
    try {
      final ink = ml.Ink()..strokes = all;
      final candidates = await _recognizer!.recognize(ink);
      final recognized = candidates.isNotEmpty ? (candidates.first.text ?? '') : '';
      final correct = _isMatch(recognized, state.target);

      if (!correct) {
        state = state.copyWith(
          status: 'Model siap',
          lastResult: recognized.isEmpty
              ? 'Tidak terbaca. Coba tulis lebih jelas.'
              : 'Belum tepat (terbaca: "$recognized", target: "${state.target}")',
        );
        return;
      }

      // benar → kirim progress
      state = state.copyWith(posting: true);
      final token = await _ref.read(authTokenFutureProvider.future);
      if (token == null) {
        state = state.copyWith(status: 'Token kosong / belum login');
        return;
      }
      final res = await _service.postProgress(
        childId: state.childId,
        token: token,
        questionId: state.questionId!,
        invalidateCategory: state.category,
      );

      res.when(
        success: (_) {
          state = state.copyWith(
            status: 'BENAR!',
            lastResult: 'Hebat! (terbaca: "$recognized") ✅',
            posting: false,
          );
          Future.delayed(const Duration(milliseconds: 1500), () {
            _loadNextQuestion();
          });
        },
        failure: (e, _) {
          state = state.copyWith(
            status: 'Model siap',
            lastResult: 'BENAR (terbaca: "$recognized") — gagal simpan: ${e.toString()}',
            posting: false,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(status: 'Model siap', lastResult: 'Error: $e', posting: false);
    }
  }

  bool _isMatch(String a, String b) =>
      a.replaceAll(' ', '').toLowerCase() == b.replaceAll(' ', '').toLowerCase();

  void clearCanvas() {
    state = state.copyWith(strokes: const [], currentStroke: null, lastResult: null);
  }

  void dispose() {
    try { _recognizer?.close(); } catch (_) {}
    super.dispose();
  }
}

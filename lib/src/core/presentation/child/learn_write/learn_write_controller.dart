import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart'
as ml;

import 'learn_write_state.dart';

final learnWriteProvider =
StateNotifierProvider<LearnWriteController, LearnWriteState>((ref) {
  final c = LearnWriteController();
  ref.onDispose(() => c.dispose());
  return c;
});

class LearnWriteController extends StateNotifier<LearnWriteState> {
  LearnWriteController() : super(const LearnWriteState()) {
    _initModel();
  }

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

  void startStroke(Offset p) {
    final t = DateTime.now().millisecondsSinceEpoch;
    final s = ml.Stroke();
    s.points = [ml.StrokePoint(x: p.dx, y: p.dy, t: t)];
    state = state.copyWith(currentStroke: s, lastResult: null);
  }

  static const double _minDelta = 1.5;

  void updateStroke(Offset p) {
    final cur = state.currentStroke;
    if (cur == null) return;
    cur.points = cur.points ?? <ml.StrokePoint>[];
    final last = cur.points.isNotEmpty ? cur.points.last : null;
    if (last != null) {
      final dx = p.dx - last.x;
      final dy = p.dy - last.y;
      if ((dx * dx + dy * dy) < (_minDelta * _minDelta)) {
        return;
      }
    }

    cur.points.add(
      ml.StrokePoint(
        x: p.dx,
        y: p.dy,
        t: DateTime.now().millisecondsSinceEpoch,
      ),
    );
    state = state.copyWith(currentStroke: cur);
  }

  void endStroke() {
    final cur = state.currentStroke;
    if (cur == null) return;
    if (cur.points.isEmpty) {
      state = state.copyWith(currentStroke: null);
      return;
    }

    final list = [...state.strokes, cur];
    state = state.copyWith(strokes: list, currentStroke: null);
  }

  void undo() {
    if (state.currentStroke != null) {
      state = state.copyWith(currentStroke: null);
    } else if (state.strokes.isNotEmpty) {
      final list = [...state.strokes]..removeLast();
      state = state.copyWith(strokes: list);
    }
  }
  Future<void> check(String target) async {
    if (!state.modelReady || _recognizer == null) return;

    final all = [
      ...state.strokes,
      if (state.currentStroke != null) state.currentStroke!,
    ];
    if (all.isEmpty) {
      state = state.copyWith(lastResult: 'Tulis dulu di papan 🙂');
      return;
    }

    state = state.copyWith(status: 'Mengenali…');

    try {
      final ink = ml.Ink();
      ink.strokes = all;
      final candidates = await _recognizer!.recognize(ink /*, context: ctx*/);
      final recognized = candidates.isNotEmpty ? (candidates.first.text ?? '') : '';
      final correct = _isMatch(recognized, target);
      state = state.copyWith(
        status: 'Model siap',
        lastResult: recognized.isEmpty
            ? 'Tidak terbaca. Coba tulis lebih jelas.'
            : (correct
            ? 'BENAR (terbaca: "$recognized")'
            : 'Belum tepat (terbaca: "$recognized", target: "$target")'),
      );
    } catch (e) {
      state = state.copyWith(status: 'Model siap', lastResult: 'Error: $e');
    }
  }

  bool _isMatch(String a, String b) {
    final r = a.replaceAll(' ', '').toLowerCase();
    final e = b.replaceAll(' ', '').toLowerCase();
    return r == e;
  }

  void dispose() {
    try {
      _recognizer?.close();
    } catch (_) {}
    super.dispose();
  }
}

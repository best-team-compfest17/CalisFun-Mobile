import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart' as ml;
import '../../../../constants/constants.dart';

class LearnWriteState {
  final String childId;
  final WritingCategory category;

  final List<ml.Stroke> strokes;
  final ml.Stroke? currentStroke;
  final bool modelReady;
  final String status;
  final String? lastResult;
  final int? level;
  final String target;
  final bool posting;
  final bool loading;
  final String? questionId;

  const LearnWriteState({
    required this.childId,
    required this.category,
    this.strokes = const [],
    this.currentStroke,
    this.modelReady = false,
    this.status = 'Menyiapkan model…',
    this.lastResult,
    this.target = '',
    this.posting = false,
    this.loading = false,
    this.questionId,
    this.level,
  });

  LearnWriteState copyWith({
    String? childId,
    WritingCategory? category,
    List<ml.Stroke>? strokes,
    ml.Stroke? currentStroke,
    bool? modelReady,
    String? status,
    String? lastResult,
    String? target,
    bool? posting,
    bool? loading,
    String? questionId,
    int? level,
  }) {
    return LearnWriteState(
      childId: childId ?? this.childId,
      category: category ?? this.category,
      strokes: strokes ?? this.strokes,
      currentStroke: currentStroke,
      modelReady: modelReady ?? this.modelReady,
      status: status ?? this.status,
      lastResult: lastResult,
      target: target ?? this.target,
      posting: posting ?? this.posting,
      loading: loading ?? this.loading,
      questionId: questionId ?? this.questionId,
      level: level ?? this.level,
    );
  }
}

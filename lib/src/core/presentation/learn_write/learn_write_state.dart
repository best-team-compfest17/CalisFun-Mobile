import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart' as ml;

class LearnWriteState {
  final List<ml.Stroke> strokes;
  final ml.Stroke? currentStroke;
  final bool modelReady;
  final String status;
  final String? lastResult;

  const LearnWriteState({
    this.strokes = const [],
    this.currentStroke,
    this.modelReady = false,
    this.status = 'Menyiapkan model…',
    this.lastResult,
  });

  LearnWriteState copyWith({
    List<ml.Stroke>? strokes,
    ml.Stroke? currentStroke,
    bool? modelReady,
    String? status,
    String? lastResult,
  }) {
    return LearnWriteState(
      strokes: strokes ?? this.strokes,
      currentStroke: currentStroke,
      modelReady: modelReady ?? this.modelReady,
      status: status ?? this.status,
      lastResult: lastResult,
    );
  }
}

class SpeechState {
  final bool available;
  final bool listening;
  final String words;
  final double confidence;
  final String status;
  final String? error;

  const SpeechState({
    this.available = false,
    this.listening = false,
    this.words = '',
    this.confidence = 0.0,
    this.status = 'notListening',
    this.error,
  });

  SpeechState copyWith({
    bool? available,
    bool? listening,
    String? words,
    double? confidence,
    String? status,
    String? error,
  }) {
    return SpeechState(
      available: available ?? this.available,
      listening: listening ?? this.listening,
      words: words ?? this.words,
      confidence: confidence ?? this.confidence,
      status: status ?? this.status,
      error: error,
    );
  }
}

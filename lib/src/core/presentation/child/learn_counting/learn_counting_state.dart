import 'package:flutter/foundation.dart';

import '../../../../constants/constants.dart';


extension OperatorX on Operator {
  String get symbol => switch (this) {
    Operator.add => '+',
    Operator.sub => '−',
    Operator.mul => '×',
    Operator.div => '÷',
  };
}

@immutable
class Question {
  final int a, b, answer;
  final Operator op;
  const Question({required this.a, required this.b, required this.op, required this.answer});
  String get display => '$a ${op.symbol} $b = ?';
}

@immutable
class LearnCountingState {
  final bool initialized;
  final Difficulty difficulty;
  final List<Question> questions;
  final int currentIndex, correctCount;
  final bool finished;
  final bool? lastAnswerCorrect;
  final String currentInput;
  final int totalSeconds, remainingSeconds;
  final bool timeUp, ticking;
  final bool promotionDone;
  final Difficulty? promotedTo;

  const LearnCountingState({
    this.initialized = false,
    this.difficulty = Difficulty.easy,
    this.questions = const [],
    this.currentIndex = 0,
    this.correctCount = 0,
    this.finished = false,
    this.lastAnswerCorrect,
    this.currentInput = '',
    this.totalSeconds = 180,
    this.remainingSeconds = 180,
    this.timeUp = false,
    this.ticking = false,
    this.promotionDone = false,
    this.promotedTo,
  });

  Question? get currentQuestion =>
      (currentIndex >= 0 && currentIndex < questions.length) ? questions[currentIndex] : null;

  double get progress => questions.isEmpty ? 0 : (currentIndex / questions.length);

  LearnCountingState copyWith({
    bool? initialized,
    Difficulty? difficulty,
    List<Question>? questions,
    int? currentIndex,
    int? correctCount,
    bool? finished,
    bool? lastAnswerCorrect,
    String? currentInput,
    int? totalSeconds,
    int? remainingSeconds,
    bool? timeUp,
    bool? ticking,
    bool? promotionDone,
    Difficulty? promotedTo,
  }) {
    return LearnCountingState(
      initialized: initialized ?? this.initialized,
      difficulty: difficulty ?? this.difficulty,
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      correctCount: correctCount ?? this.correctCount,
      finished: finished ?? this.finished,
      lastAnswerCorrect: lastAnswerCorrect,
      currentInput: currentInput ?? this.currentInput,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      timeUp: timeUp ?? this.timeUp,
      ticking: ticking ?? this.ticking,
      promotionDone: promotionDone ?? this.promotionDone,
      promotedTo: promotedTo ?? this.promotedTo,
    );
  }
}

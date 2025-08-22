import 'dart:async';
import 'dart:math';
import 'package:calisfun/src/network/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constants/constants.dart';
import '../../../application/child_by_id_provider.dart';
import '../../../core.dart';
import 'learn_counting_state.dart';

final learnCountingControllerProvider =
StateNotifierProvider.autoDispose<LearnCountingController, LearnCountingState>(
      (ref) => LearnCountingController(ref),
);

class LearnCountingController extends StateNotifier<LearnCountingState> {
  LearnCountingController(this._ref) : super(const LearnCountingState());

  final Ref _ref;
  String? _childId;

  final TextEditingController answerController = TextEditingController();
  final _rng = Random();
  Timer? _ticker;

  void initIfNeeded({
    required Difficulty difficulty,
    required String? childId,
    int total = 10,
  }) {
    if (state.initialized && state.difficulty == difficulty && state.questions.isNotEmpty) {
      return;
    }
    _childId = childId;
    state = state.copyWith(initialized: true, difficulty: difficulty);
    _start(total: total);
  }

  void _finish() {
    _cancelTimer();
    state = state.copyWith(ticking: false);

    final id = _childId;
    if (id != null) {
      Future.microtask(() async {
        final svc = _ref.read(userServiceProvider);
        final res = await svc.promoteCountingDifficultyIfEligible(
          childId: id,
          currentDifficulty: state.difficulty,
          correct: state.correctCount,
          total: state.questions.length,
        );

        await res.when(
          success: (ok) async {
            if (ok) {
              _ref.invalidate(childByIdProvider(id));
              state = state.copyWith(
                promotionDone: true,
                promotedTo: _next(state.difficulty),
              );
            }
          },
          failure: (_, __) async {
          },
        );
      });
    }
  }

  Difficulty? _next(Difficulty d) => switch (d) {
    Difficulty.easy => Difficulty.medium,
    Difficulty.medium => Difficulty.hard,
    Difficulty.hard => null,
  };

  void _start({int total = 10}) {
    final qs = _generateQuestions(state.difficulty, total);
    answerController.clear();
    _cancelTimer();

    state = state.copyWith(
      questions: qs,
      currentIndex: 0,
      correctCount: 0,
      finished: false,
      lastAnswerCorrect: null,
      currentInput: '',
      remainingSeconds: 180,
      timeUp: false,
      ticking: true,
    );

    _startTimer();
  }

  void updateInput(String v) =>
      state = state.copyWith(currentInput: v, lastAnswerCorrect: null);

  void submit() {
    final q = state.currentQuestion;
    if (q == null) return;

    final user = int.tryParse(state.currentInput.trim());
    final correct = (user != null && user == q.answer);
    final newCorrect = correct ? state.correctCount + 1 : state.correctCount;
    final isLast = state.currentIndex + 1 >= state.questions.length;

    state = state.copyWith(
      correctCount: newCorrect,
      lastAnswerCorrect: correct,
      finished: isLast,
      currentIndex: isLast ? state.currentIndex : state.currentIndex + 1,
      currentInput: '',
    );
    answerController.text = '';

    if (isLast) _finish();
  }

  void handleExit() => reset();

  void reset() {
    _cancelTimer();
    answerController.clear();
    state = const LearnCountingState();
  }

  @override
  void dispose() {
    _cancelTimer();
    answerController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _ticker = Timer.periodic(const Duration(seconds: 1), (t) {
      final next = state.remainingSeconds - 1;
      if (next <= 0) {
        _cancelTimer();
        state = state.copyWith(
          remainingSeconds: 0,
          timeUp: true,
          finished: true,
          ticking: false,
        );
      } else {
        state = state.copyWith(remainingSeconds: next, ticking: true);
      }
    });
  }

  void _cancelTimer() {
    _ticker?.cancel();
    _ticker = null;
  }

  List<Question> _generateQuestions(Difficulty d, int total) {
    final ops = Operator.values;
    return List.generate(
      total,
          (_) => _randomQuestionBy(d, ops[_rng.nextInt(ops.length)]),
    );
  }

  Question _randomQuestionBy(Difficulty d, Operator op) => switch (op) {
    Operator.add => _randAdd(_range(d)),
    Operator.sub => _randSub(_range(d)),
    Operator.mul => _randMul(_range(d)),
    Operator.div => _randDiv(_range(d)),
  };

  ({int min, int max, int mulMax, int divMax}) _range(Difficulty d) => switch (d) {
    Difficulty.easy => (min: 0, max: 20, mulMax: 10, divMax: 10),
    Difficulty.medium => (min: 0, max: 100, mulMax: 12, divMax: 12),
    Difficulty.hard => (min: 0, max: 999, mulMax: 20, divMax: 20),
  };

  Question _randAdd(({int min, int max, int mulMax, int divMax}) r) {
    final a = _rngIn(r.min, r.max), b = _rngIn(r.min, r.max);
    return Question(a: a, b: b, op: Operator.add, answer: a + b);
  }

  Question _randSub(({int min, int max, int mulMax, int divMax}) r) {
    var a = _rngIn(r.min, r.max), b = _rngIn(r.min, r.max);
    if (b > a) {
      final t = a;
      a = b;
      b = t;
    }
    return Question(a: a, b: b, op: Operator.sub, answer: a - b);
  }

  Question _randMul(({int min, int max, int mulMax, int divMax}) r) {
    final a = _rngIn(0, r.mulMax), b = _rngIn(0, r.mulMax);
    return Question(a: a, b: b, op: Operator.mul, answer: a * b);
  }

  Question _randDiv(({int min, int max, int mulMax, int divMax}) r) {
    final b = _rngIn(1, r.divMax), q = _rngIn(0, r.divMax), a = b * q;
    return Question(a: a, b: b, op: Operator.div, answer: q);
  }

  int _rngIn(int min, int max) => min + _rng.nextInt(max - min + 1);
}

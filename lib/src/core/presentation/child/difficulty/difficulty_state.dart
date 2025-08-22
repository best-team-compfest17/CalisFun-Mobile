import 'package:flutter/foundation.dart';
import '../../../../constants/constants.dart';

@immutable
class DifficultyState {
  final Difficulty? selected;
  const DifficultyState({this.selected});

  DifficultyState copyWith({Difficulty? selected}) =>
      DifficultyState(selected: selected ?? this.selected);
}


Difficulty difficultyFromBackend(String? s) {
  switch (s) {
    case 'hard': return Difficulty.hard;
    case 'medium': return Difficulty.medium;
    case 'easy':
    default: return Difficulty.easy;
  }
}

List<Difficulty> unlockedDifficulties(Difficulty base) {
  switch (base) {
    case Difficulty.easy: return const [Difficulty.easy];
    case Difficulty.medium: return const [Difficulty.easy, Difficulty.medium];
    case Difficulty.hard: return const [Difficulty.easy, Difficulty.medium, Difficulty.hard];
  }
}

String labelDifficulty(Difficulty d) {
  switch (d) {
    case Difficulty.easy: return 'Mudah';
    case Difficulty.medium: return 'Sedang';
    case Difficulty.hard: return 'Sulit';
  }
}


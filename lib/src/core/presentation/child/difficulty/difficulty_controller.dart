import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constants/constants.dart';
import 'difficulty_state.dart';

final difficultyControllerProvider =
StateNotifierProvider<DifficultyController, DifficultyState>(
      (ref) => DifficultyController(),
);

class DifficultyController extends StateNotifier<DifficultyState> {
  DifficultyController() : super(const DifficultyState());

  void select(Difficulty d) => state = state.copyWith(selected: d);
  void clear() => state = const DifficultyState();
}


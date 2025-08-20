part of 'domain.dart';

class Child {
  final String id;
  final String name;
  final String avatarImg;
  final int level;
  final int xp;
  final Progress progress;
  final String countingDifficulty;
  final int streak;
  final DateTime lastStreakUpdate;

  const Child({
    required this.id,
    required this.name,
    required this.avatarImg,
    this.level = 1,
    this.xp = 0,
    required this.progress,
    this.countingDifficulty = "easy",
    this.streak = 0,
    required this.lastStreakUpdate,
  });
}

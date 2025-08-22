part of 'domain.dart';

class LeaderboardUser {
  final String id;
  final String name;
  final String? avatarImg;
  final int level;
  final int xp;

  LeaderboardUser({
    required this.id,
    required this.name,
    required this.level,
    required this.xp,
    this.avatarImg,
  });
}

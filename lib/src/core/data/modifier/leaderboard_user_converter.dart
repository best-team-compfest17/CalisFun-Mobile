part of '../data.dart';

class LeaderboardConverter {
  static LeaderboardUser fromJson(Map<String, dynamic> json) {
    return LeaderboardUser(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      avatarImg: (json['avatarImg'] ?? json['avatar_img'] ?? '').toString(),
      level: (json['level'] ?? 1) is num ? (json['level'] as num).toInt() : 1,
      xp: (json['xp'] ?? 0) is num ? (json['xp'] as num).toInt() : 0,
    );
  }

  static List<LeaderboardUser> fromList(dynamic data) {
    final list = (data is List) ? data : const <dynamic>[];
    return list.whereType<Map<String, dynamic>>().map(fromJson).toList(growable: false);
  }
}

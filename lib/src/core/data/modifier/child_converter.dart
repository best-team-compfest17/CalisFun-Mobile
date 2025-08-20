part of '../data.dart';

class ChildConverter {
  static Child fromJson(Map<String, dynamic> json) {
    return Child(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      avatarImg: (json['avatarImg'] ?? json['avatar_img'] ?? '').toString(),
      level: (json['level'] ?? 1) is num ? (json['level'] as num).toInt() : 1,
      xp: (json['xp'] ?? 0) is num ? (json['xp'] as num).toInt() : 0,
      progress: ProgressConverter.fromJson(json['progress'] as Map<String, dynamic>?),
      countingDifficulty:
      (json['countingDifficulty'] ?? json['counting_difficulty'] ?? 'easy').toString(),
      streak: (json['streak'] ?? 0) is num ? (json['streak'] as num).toInt() : 0,
      lastStreakUpdate: _parseDate(json['lastStreakUpdate'] ?? json['last_streak_update']),
    );
  }

  static List<Child> fromList(dynamic data) {
    final list = (data is List) ? data : const <dynamic>[];
    return list
        .whereType<Map<String, dynamic>>()
        .map(fromJson)
        .toList(growable: false);
  }

  static Map<String, dynamic> toJson(Child c) => {
    'id': c.id,
    'name': c.name,
    'avatarImg': c.avatarImg,
    'level': c.level,
    'xp': c.xp,
    'progress': ProgressConverter.toJson(c.progress),
    'countingDifficulty': c.countingDifficulty,
    'streak': c.streak,
    'lastStreakUpdate': c.lastStreakUpdate.toIso8601String(),
  };

  static DateTime _parseDate(dynamic v) {
    if (v == null || v.toString().isEmpty) return DateTime.fromMillisecondsSinceEpoch(0);
    return v is DateTime ? v : DateTime.tryParse(v.toString()) ?? DateTime.now();
  }
}

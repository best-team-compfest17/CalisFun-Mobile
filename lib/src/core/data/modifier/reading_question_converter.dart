part of '../data.dart';

class ReadingQuestionConverter {
  static ReadingQuestion fromJson(Map<String, dynamic> json) {
    return ReadingQuestion(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      word: (json['word'] ?? '').toString(),
      category: (json['category'] ?? '').toString(),
      level: json['level'] is int
          ? json['level'] as int
          : int.tryParse('${json['level'] ?? 0}') ?? 0,
    );
  }

  static Map<String, dynamic> toJson(ReadingQuestion q) => {
    '_id': q.id,
    'word': q.word,
    'category': q.category,
    'level': q.level,
  };
}


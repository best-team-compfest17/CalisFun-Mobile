part of 'domain.dart';

class WritingQuestion {
  final String id;
  final String word;
  final String category; // "word" | "number" | "letter"
  final int level;

  const WritingQuestion({
    required this.id,
    required this.word,
    required this.category,
    required this.level,
  });
}

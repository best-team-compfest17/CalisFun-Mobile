part of 'domain.dart';

class ReadingQuestion {
  final String id;
  final String word;
  final String category;
  final int level;

  const ReadingQuestion({
    required this.id,
    required this.word,
    required this.category,
    required this.level,
  });
}

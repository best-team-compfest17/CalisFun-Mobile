part of '../data.dart';

class ProgressConverter {
  static Progress fromJson(Map<String, dynamic>? json) {
    final m = json ?? const {};
    return Progress(
      readingIds: _ids(m['reading']),
      writingIds: _ids(m['writing']),
    );
  }

  static Map<String, dynamic> toJson(Progress p) => {
    'reading': p.readingIds,
    'writing': p.writingIds,
  };

  static List<String> _ids(dynamic v) {
    if (v is List) {
      return v.map((e) => e is Map ? (e['_id'] ?? e['id'] ?? e).toString() : e.toString()).toList();
    }
    return const [];
  }
}

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../network/network.dart';
import '../../shared/preferences/preferences.dart';
import '../data/data.dart';
import '../domain/domain.dart';

final readingQuestionProvider =
FutureProvider.family<ReadingQuestion, String>((ref, childId) async {
  final dio = ref.read(dioClientProvider);
  final pref = ref.read(userPreferenceProvider);

  final token = await pref.getToken();
  if (token == null || token.isEmpty) {
    throw Exception('Token tidak tersedia');
  }

  final res = await dio.get(
    '${Endpoint.getReading}/$childId',
    queryParameters: const {'category': 'word'},
    options: Options(headers: {'Authorization': 'Bearer $token'}),
  );

  Map<String, dynamic> map;
  if (res is Map<String, dynamic>) {
    map = res as Map<String, dynamic>;
  } else if (res is String) {
    map = jsonDecode(res as String) as Map<String, dynamic>;
  } else {
    throw Exception('Format respons tidak dikenali');
  }

  return ReadingQuestionConverter.fromJson(map);
});

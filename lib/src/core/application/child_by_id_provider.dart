import 'package:calisfun/src/network/network.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/application.dart'; // userServiceProvider
import '../domain/domain.dart';          // Child

final childByIdProvider =
FutureProvider.autoDispose.family<Child, String>((ref, id) async {
  final svc = ref.read(userServiceProvider);
  final res = await svc.fetchChildById(id);
  return res.when(
    success: (c) => c,
    failure: (e, _) => throw e,
  );
});

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calisfun/main.dart';

void main() {
  testWidgets('MyApp builds without crashing', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MyApp()),
    );

    // Biarkan Splash menyelesaikan Timer 600ms
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();

    // Smoke: app ter-render (sesuaikan root yang pasti ada di MyApp)
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}

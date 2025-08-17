import 'package:calisfun/src/routes/app_routes.dart';
import 'package:calisfun/src/widgets/app_button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OnBoardingPage extends ConsumerWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: AppButton(
          text: 'Lanjut Masuk',
          onPressed: () => context.pushNamed(Routes.signin.name),
        ),
      ),
    );
  }
}

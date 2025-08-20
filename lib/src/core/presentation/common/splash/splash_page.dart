import 'dart:async';
import 'package:calisfun/src/constants/constants.dart';
import 'package:calisfun/src/network/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/routes.dart';
import 'package:calisfun/src/shared/preferences/preferences.dart';
import 'package:calisfun/src/core/application/application.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await Future.delayed(const Duration(milliseconds: 600));
    final hasSeenIntro = await ref.read(introPreferenceProvider).getHasSeenIntro();
    if (!mounted) return;

    if (!hasSeenIntro) {
      context.goNamed(Routes.onboarding.name);
      return;
    }

    final token = await ref.read(userPreferenceProvider).getToken();
    if (!mounted) return;

    if (token == null || token.isNotEmpty == false) {
      context.goNamed(Routes.signin.name);
      return;
    }

    final res = await ref.read(userServiceProvider).meData(token);
    if (!mounted) return;

    res.when(
      success: (user) {
        context.goNamed(Routes.botnavbar.name);
      },
      failure: (err, st) {
        context.goNamed(Routes.signin.name);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.mainWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/calisfun_logo.png', width: 200.w, height: 200.h),
            Text('CalisFun', style: TypographyApp.headingLargeBold),
          ],
        ),
      ),
    );
  }
}

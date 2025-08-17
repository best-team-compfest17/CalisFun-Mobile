import 'package:calisfun/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/widgets.dart';

class ForgetPasswordPage extends ConsumerWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ColorApp.mainWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap.h80,
              AppPrevButton(),
              Gap.h16,
              Text('Lupa', style: TypographyApp.headingLargeBoldPrimary,),
              Text('Kata Sandi', style: TypographyApp.headingLargeBold,),
            ],
          ),
        ),
      ),
    );
  }
}

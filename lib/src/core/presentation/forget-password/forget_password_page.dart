import 'package:calisfun/src/constants/constants.dart';
import 'package:calisfun/src/core/presentation/signin/signin_controller.dart';
import 'package:calisfun/src/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/widgets.dart';

class ForgetPasswordPage extends ConsumerWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signinControllerProvider);
    final controller = ref.read(signinControllerProvider.notifier);
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
              Row(
                children: [
                  Text('Lupa', style: TypographyApp.headingLargeBoldPrimary),
                  Gap.w10,
                  Text('Kata Sandi?', style: TypographyApp.headingLargeBold),
                ],
              ),
              Text(
                'Masukkan email yang terdaftar. Kami akan mengirim tautan untuk membuat kata sandi baru.',
                style: TypographyApp.bodyNormalRegular,
              ),
              Gap.h12,
              Text('Email', style: TypographyApp.labelSmallMedium),
              Gap.h12,
              AppTextField(
                hintText: 'email@gmail.com',
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeApp.w16,
                  vertical: SizeApp.h12,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    'assets/icons/email_ic.svg',
                    width: SizeApp.w24,
                    height: SizeApp.h24,
                    colorFilter: const ColorFilter.mode(
                      ColorApp.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                hintStyle: TypographyApp.labelSmallMediumGrey,
                inputStyle: TypographyApp.labelSmallMedium,
                validator: controller.validateEmail,
              ),
              Gap.h24,
              //button
              AppButton(
                text: state.isLoading ? 'Loading' : 'Selanjutnya',
                textStyle: TypographyApp.bodyNormalBold.copyWith(
                  color: Colors.white,
                ),
                onPressed: () => context.pushNamed(Routes.verificationOtp.name),
                width: double.infinity,
                height: SizeApp.h52,
                backgroundColor: ColorApp.primary,
                horizontalPad: SizeApp.w16,
                verticalPad: SizeApp.h12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

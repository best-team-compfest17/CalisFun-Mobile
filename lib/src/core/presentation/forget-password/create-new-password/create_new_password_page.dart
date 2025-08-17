import 'package:calisfun/src/constants/constants.dart';
import 'package:calisfun/src/core/presentation/signin/signin_controller.dart';
import 'package:calisfun/src/routes/app_routes.dart';
import 'package:calisfun/src/widgets/app_button/app_button.dart';
import 'package:calisfun/src/widgets/app_prev_button/app_prev_button.dart';
import 'package:calisfun/src/widgets/app_text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class CreateNewPasswordPage extends ConsumerWidget {
  const CreateNewPasswordPage({super.key});

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
                  Text('Buat', style: TypographyApp.headingLargeBoldPrimary),
                  Gap.w10,
                  Text(
                    'Kata Sandi Baru',
                    style: TypographyApp.headingLargeBold,
                  ),
                ],
              ),
              Text(
                'Gunakan kata sandi yang mudah diingat namun sulit ditebak',
                style: TypographyApp.bodyNormalRegular,
              ),
              Gap.h12,
              Text('Kata sandi baru', style: TypographyApp.labelSmallMedium),
              Gap.h12,
              // Password input field
              AppTextField(
                hintText: 'kata sandi',
                controller: controller.passwordController,
                obscureText: state.isObscure,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeApp.w16,
                  vertical: SizeApp.h12,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    'assets/icons/pass_ic.svg',
                    width: SizeApp.w24,
                    height: SizeApp.h24,
                    colorFilter: const ColorFilter.mode(
                      ColorApp.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: controller.toggleObscure,
                  icon: SvgPicture.asset(
                    state.isObscure
                        ? 'assets/icons/pass_obsecure_true.svg'
                        : 'assets/icons/pass_obsecure_false.svg',
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      ColorApp.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                hintStyle: TypographyApp.labelSmallMediumGrey,
                inputStyle: TypographyApp.labelSmallMedium,
                validator: controller.validatePassword,
              ),
              Gap.h12,
              Text(
                'Konfirmasi Kata sandi baru',
                style: TypographyApp.labelSmallMedium,
              ),
              Gap.h12,
              // Password input field
              AppTextField(
                hintText: 'kata sandi',
                controller: controller.passwordController,
                obscureText: state.isObscure,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeApp.w16,
                  vertical: SizeApp.h12,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    'assets/icons/pass_ic.svg',
                    width: SizeApp.w24,
                    height: SizeApp.h24,
                    colorFilter: const ColorFilter.mode(
                      ColorApp.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: controller.toggleObscure,
                  icon: SvgPicture.asset(
                    state.isObscure
                        ? 'assets/icons/pass_obsecure_true.svg'
                        : 'assets/icons/pass_obsecure_false.svg',
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      ColorApp.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                hintStyle: TypographyApp.labelSmallMediumGrey,
                inputStyle: TypographyApp.labelSmallMedium,
                validator: controller.validatePassword,
              ),
              Gap.h24,
              //button
              AppButton(
                text: state.isLoading ? 'Loading' : 'Ubah Kata Sandi',
                textStyle: TypographyApp.bodyNormalBold.copyWith(
                  color: Colors.white,
                ),
                onPressed: () => context.pushNamed(Routes.signup.name),
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

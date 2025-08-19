import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:calisfun/src/core/presentation/auth/signin/signin_controller.dart';
import 'package:calisfun/src/core/presentation/auth/signin/signin_state.dart';

import '../../../../constants/constants.dart';
import '../../../../routes/routes.dart';
import '../../../../widgets/widgets.dart';

class SigninPage extends ConsumerWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SigninState>(signinControllerProvider, (prev, next) {
      final value = next.loginValue;

      value.whenOrNull(
        data: (_) {
          context.goNamed(Routes.selectUser.name);
        },
        error: (e, st) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login gagal: $e')),
          );
        },
      );
    });
    final state = ref.watch(signinControllerProvider);
    final controller  = ref.read(signinControllerProvider.notifier);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap.h80,
                  Text('Selamat', style: TypographyApp.headingLargeBoldPrimary,),
                  Text('Datang', style: TypographyApp.headingLargeBold,),
                  Gap.h16,
                  Text('Yuk, isi email dan kata sandinya biar kita bisa mulai petualangan!', style: TypographyApp.bodyNormalRegular,),
                  Gap.h56,
                  Text('Masuk', style: TypographyApp.headingLargeMedium,),
                  Gap.h16,
                  Text('Email', style: TypographyApp.labelSmallMedium,),
                  Gap.h12,
                  // Email input field
                  AppTextField(
                    hintText: 'email@gmail.com',
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: SizeApp.w16, vertical: SizeApp.h12,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        'assets/icons/email_ic.svg',
                        width: SizeApp.w24,
                        height: SizeApp.h24,
                        colorFilter: const ColorFilter.mode(ColorApp.primary, BlendMode.srcIn),
                      ),
                    ),
                    hintStyle: TypographyApp.labelSmallMediumGrey,
                    inputStyle: TypographyApp.labelSmallMedium,
                    validator: controller.validateEmail,
                  ),
                  Gap.h12,
                  Text('Password', style: TypographyApp.labelSmallMedium,),
                  Gap.h12,
                  // Password input field
                  AppTextField(
                    hintText: 'kata sandi',
                    controller: controller.passwordController,
                    obscureText: state.isObscure,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: SizeApp.w16, vertical: SizeApp.h12,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        'assets/icons/pass_ic.svg',
                        width: SizeApp.w24,
                        height: SizeApp.h24,
                        colorFilter: const ColorFilter.mode(ColorApp.primary, BlendMode.srcIn),
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
                        colorFilter: const ColorFilter.mode(ColorApp.primary, BlendMode.srcIn),
                      ),
                    ),
                    hintStyle: TypographyApp.labelSmallMediumGrey,
                    inputStyle: TypographyApp.labelSmallMedium,
                    validator: controller.validatePassword,
                  ),
                  Gap.h24,
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => context.pushNamed(Routes.forgetPassword.name),
                      child: Text('Lupa kata sandi?', style: TypographyApp.labelSmallMedium.copyWith(color: ColorApp.primary),),
                    ),
                  ),
                  Gap.h24,
                  //button
                  AppButton(
                    text: state.isLoading ? 'Loading' : 'Masuk',
                    textStyle: TypographyApp.bodyNormalBold.copyWith(color: Colors.white),
                    onPressed: controller.submit,
                    width: double.infinity,
                    height: SizeApp.h52,
                    backgroundColor: ColorApp.primary,
                    horizontalPad: SizeApp.w16,
                    verticalPad: SizeApp.h12,
                  ),
                  Gap.h56,
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Belum punya akun?', style: TypographyApp.bodyNormalRegular,),
                        Gap.w4,
                        InkWell(
                          onTap: () => context.pushNamed(Routes.signup.name),
                          child: Text('Daftar', style: TypographyApp.bodyNormalMedium.copyWith(color: ColorApp.primary),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

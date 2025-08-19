import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:calisfun/src/constants/constants.dart';
import 'package:calisfun/src/core/presentation/auth/signin/signin_controller.dart';
import 'package:calisfun/src/routes/app_routes.dart';
import 'package:calisfun/src/widgets/widgets.dart';

class VerificationOtpPage extends ConsumerWidget {
  const VerificationOtpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signinControllerProvider);
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
                  Text(
                    'Verifikasi',
                    style: TypographyApp.headingLargeBoldPrimary,
                  ),
                  Gap.w10,
                  Text('OTP', style: TypographyApp.headingLargeBold),
                ],
              ),
              RichText(
                text: TextSpan(
                  style: TypographyApp.bodyNormalRegular,
                  children: [
                    TextSpan(
                      text:
                          'Kami telah mengirimkan OTP tersebut melalui \nemail Anda ',
                    ),
                    TextSpan(text: "", style: TypographyApp.bodyNormalBold),
                  ],
                ),
              ),
              Gap.h12,
              Text('Email', style: TypographyApp.labelSmallMedium),
              Gap.h24,
              Row(
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: TypographyApp.headingLargeBold,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: Color(0xFFF2F2F2), // abu
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Color(0xFFBDBDBD), // abu border
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Color(0xFFBDBDBD),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: ColorApp.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap.w32,
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: TypographyApp.headingLargeBold,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: Color(0xFFF2F2F2), // abu
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Color(0xFFBDBDBD), // abu border
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Color(0xFFBDBDBD),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: ColorApp.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap.w32,
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: TypographyApp.headingLargeBold,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: Color(0xFFF2F2F2), // abu
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Color(0xFFBDBDBD), // abu border
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Color(0xFFBDBDBD),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: ColorApp.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap.w32,

                  SizedBox(
                    width: 60,
                    height: 60,
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: TypographyApp.headingLargeBold,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: Color(0xFFF2F2F2), // abu
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Color(0xFFBDBDBD), // abu border
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Color(0xFFBDBDBD),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: ColorApp.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap.h24,
              //button
              AppButton(
                text: state.isLoading ? 'Loading' : 'Selanjutnya',
                textStyle: TypographyApp.bodyNormalBold.copyWith(
                  color: Colors.white,
                ),
                onPressed:
                    () => context.pushNamed(Routes.createNewPassword.name),
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

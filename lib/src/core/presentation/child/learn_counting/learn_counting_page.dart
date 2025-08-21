import 'package:calisfun/src/constants/constants.dart';
import 'package:calisfun/src/core/presentation/auth/signin/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/widgets.dart';

class LearnCountingPage extends ConsumerStatefulWidget {
  const LearnCountingPage({super.key});

  @override
  ConsumerState<LearnCountingPage> createState() => _LearnCountingPageState();
}

class _LearnCountingPageState extends ConsumerState<LearnCountingPage> {
  // Untuk tampilan saja, tidak perlu initState

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signinControllerProvider);
    final controller = ref.read(signinControllerProvider.notifier);
    return Scaffold(
      backgroundColor: ColorApp.mainWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap.h32,
                      const AppPrevButton(),
                      Gap.h16,
                      LinearProgressIndicator(
                        minHeight: SizeApp.h16,
                        borderRadius: BorderRadius.circular(100.r),
                        value: 0.1,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          ColorApp.primary,
                        ),
                        backgroundColor: ColorApp.greyInactive,
                      ),
                      Gap.h16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Kata 1 dari 10',
                            style: TypographyApp.headingSmallBold,
                          ),
                          Text(
                            'Coba lagi',
                            style: TypographyApp.headingSmallBold.copyWith(
                              color: ColorApp.error,
                            ),
                          ),
                        ],
                      ),
                      Gap.h16,
                      Container(
                        width: SizeApp.customWidth(360),
                        height: SizeApp.customHeight(200),
                        decoration: BoxDecoration(
                          color: ColorApp.primary,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Text(
                            '1+19+20 = ?',
                            style: TypographyApp.headingLargeBold.copyWith(
                              color: ColorApp.mainWhite,
                            ),
                          ),
                        ),
                      ),
                      Gap.h16,
                      AppTextField(
                        hintText: 'Masukan jawabanmu disini',
                        controller: controller.passwordController,
                        obscureText: state.isObscure,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: SizeApp.w16,
                          vertical: SizeApp.h12,
                        ),
                        hintStyle: TypographyApp.labelSmallMediumGrey,
                        inputStyle: TypographyApp.labelSmallMedium,
                        validator: controller.validatePassword,
                      ),
                      Gap.h16,
                    ],
                  ),
                ),
              ),
              AppButton(text: 'Periksa', onPressed: () {}),
              Gap.h16,
            ],
          ),
        ),
      ),
    );
  }
}

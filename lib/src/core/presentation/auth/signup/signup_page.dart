import 'package:calisfun/src/constants/constants.dart';
import 'package:calisfun/src/core/presentation/auth/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../widgets/widgets.dart';


class SignupPage extends ConsumerWidget{
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signupControllerProvider);
    final controller  = ref.read(signupControllerProvider.notifier);
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorApp.mainWhite,
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap.h80,
                  AppPrevButton(),
                  Gap.h16,
                  Text('Petualangan', style: TypographyApp.headingLargeBoldPrimary,),
                  Text('Dimulai!', style: TypographyApp.headingLargeBold,),
                  Gap.h16,
                  Text('Masukkan informasi dasar untuk memulai perjalanan belajar.', style: TypographyApp.bodyNormalRegular,),
                  Gap.h56,
                  Text('Daftar', style: TypographyApp.headingLargeMedium,),
                  Gap.h16,
                  Text('Nama', style: TypographyApp.labelSmallMedium,),
                  Gap.h16,
                  // Name input field
                  AppTextField(
                    hintText: 'Nama Anda',
                    controller: controller.nameController,
                    keyboardType: TextInputType.name,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: SizeApp.w16, vertical: SizeApp.h12,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        'assets/icons/user_ic.svg',
                        width: SizeApp.w24,
                        height: SizeApp.h24,
                        colorFilter: const ColorFilter.mode(ColorApp.primary, BlendMode.srcIn),
                      ),
                    ),
                    hintStyle: TypographyApp.labelSmallMediumGrey,
                    inputStyle: TypographyApp.labelSmallMedium,
                    validator: controller.validateName,
                  ),
                  Gap.h16,
                  Text('Email', style: TypographyApp.labelSmallMedium,),
                  Gap.h16,
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
                  Gap.h16,
                  Text('Nomor Telepon', style: TypographyApp.labelSmallMedium,),
                  Gap.h16,
                  // Phone input field
                  AppTextField(
                    hintText: 'Nomor Telepon',
                    controller: controller.phoneController,
                    keyboardType: TextInputType.phone,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: SizeApp.w16, vertical: SizeApp.h12,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        'assets/icons/phone_ic.svg',
                        width: SizeApp.w24,
                        height: SizeApp.h24,
                        colorFilter: const ColorFilter.mode(ColorApp.primary, BlendMode.srcIn),
                      ),
                    ),
                    hintStyle: TypographyApp.labelSmallMediumGrey,
                    inputStyle: TypographyApp.labelSmallMedium,
                    validator: controller.validatePhone,
                  ),
                  Gap.h16,
                  Text('Kata Sandi', style: TypographyApp.labelSmallMedium,),
                  Gap.h16,
                  // Password input field
                  AppTextField(
                    hintText: 'Kata Sandi',
                    controller: controller.passwordController,
                    obscureText: state.isObscurePassword,
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
                      onPressed: controller.toggleObscurePassword,
                      icon: SvgPicture.asset(
                        state.isObscurePassword
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
                  Gap.h16,
                  Text('Konfirmasi Kata Sandi', style: TypographyApp.labelSmallMedium,),
                  Gap.h16,
                  // Confirm Password input field
                  AppTextField(
                    hintText: 'Konfirmasi Kata Sandi',
                    controller: controller.confirmController,
                    obscureText: state.isObscureConfirm,
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
                      onPressed: controller.toggleObscureConfirm,
                      icon: SvgPicture.asset(
                        state.isObscureConfirm
                            ? 'assets/icons/pass_obsecure_true.svg'
                            : 'assets/icons/pass_obsecure_false.svg',
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(ColorApp.primary, BlendMode.srcIn),
                      ),
                    ),
                    hintStyle: TypographyApp.labelSmallMediumGrey,
                    inputStyle: TypographyApp.labelSmallMedium,
                    validator: controller.validateConfirm,
                  ),
                  Gap.h24,
                  // Terms and Conditions checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: state.agreedTnC,
                        onChanged: controller.toggleAgreeTnC,
                        activeColor: ColorApp.primary,
                      ),
                      Expanded(
                        child: Text(
                          'Saya setuju dengan syarat dan ketentuan',
                          style: TypographyApp.labelSmallMedium,
                        ),
                      ),
                    ],
                  ),
                  Gap.h24,
                  AppButton(
                    text: state.isLoading ? 'Loading' : 'Daftar',
                    textStyle: TypographyApp.bodyNormalBold.copyWith(color: Colors.white),
                    onPressed: controller.submit,
                    width: double.infinity,
                    height: SizeApp.h52,
                    backgroundColor: ColorApp.primary,
                    horizontalPad: SizeApp.w16,
                    verticalPad: SizeApp.h12,
                  ),
                  Gap.h24,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

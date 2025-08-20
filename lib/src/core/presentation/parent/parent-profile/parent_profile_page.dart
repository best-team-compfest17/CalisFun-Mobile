import 'package:calisfun/src/constants/constants.dart';
import 'package:calisfun/src/core/presentation/auth/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../widgets/widgets.dart';

class ParentProfilePage extends ConsumerWidget {
  const ParentProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signupControllerProvider);
    final controller = ref.read(signupControllerProvider.notifier);

    return Scaffold(
      backgroundColor: ColorApp.mainWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap.h80,
              Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppPrevButton(),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Profile Akun',
                      style: TypographyApp.headingLargeBoldPrimary,
                    ),
                  ),
                ],
              ),
              Gap.h16,
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRqUaGFKWrrv_RskYoykH2ONRynGRAAG6F0A&s',
                      ),
                    ),
                    Gap.h12,
                  ],
                ),
              ),
              Text('Nama', style: TypographyApp.labelSmallMedium),
              Gap.h16,
              // Name input field
              AppTextField(
                hintText:
                    controller.nameController.text.isNotEmpty
                        ? controller.nameController.text
                        : 'Budi',
                controller: controller.nameController,
                keyboardType: TextInputType.name,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeApp.w16,
                  vertical: SizeApp.h12,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    'assets/icons/user_ic.svg',
                    width: SizeApp.w24,
                    height: SizeApp.h24,
                    colorFilter: const ColorFilter.mode(
                      ColorApp.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                hintStyle: TypographyApp.labelSmallBold,
                inputStyle: TypographyApp.labelSmallMedium,
                validator: controller.validateName,
                onChanged: controller.onNameChanged,
              ),
              Gap.h16,
              Text('Email', style: TypographyApp.labelSmallMedium),
              Gap.h12,
              // Email input field
              AppTextField(
                hintText:
                    controller.emailController.text.isNotEmpty
                        ? controller.emailController.text
                        : 'budi@gmail.com',
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
                hintStyle: TypographyApp.labelSmallBold,
                inputStyle: TypographyApp.labelSmallMedium,
                validator: controller.validateEmail,
              ),
              Gap.h16,
              Text('Nomor Telepon', style: TypographyApp.labelSmallMedium),
              Gap.h16,
              // Phone input field
              AppTextField(
                hintText:
                    controller.phoneController.text.isNotEmpty
                        ? controller.phoneController.text
                        : '081234567890',
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeApp.w16,
                  vertical: SizeApp.h12,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    'assets/icons/phone_ic.svg',
                    width: SizeApp.w24,
                    height: SizeApp.h24,
                    colorFilter: const ColorFilter.mode(
                      ColorApp.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                hintStyle: TypographyApp.labelSmallBold,
                inputStyle: TypographyApp.labelSmallMedium,
                validator: controller.validatePhone,
                onChanged: controller.onPhoneChanged,
              ),
              Gap.h32,
              AppButton(
                backgroundColor: ColorApp.easy,
                text: 'Edit',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// parent_profile_page.dart
import 'package:calisfun/src/constants/constants.dart';
import 'package:calisfun/src/core/presentation/parent/parent-profile/parent_profile_controller.dart';
import 'package:calisfun/src/core/presentation/parent/parent-profile/parent_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../network/network.dart';
import '../../../../widgets/widgets.dart';

class ParentProfilePage extends ConsumerWidget {
  const ParentProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(parentProfileControllerProvider);
    final controller = ref.read(parentProfileControllerProvider.notifier);

    ref.listen<ParentProfileState>(
      parentProfileControllerProvider,
          (prev, next) {
        final prevValue = prev?.profileValue;
        final nextValue = next.profileValue;

        if (prevValue == nextValue) return;

        nextValue.when(
          data: (user) {
            if (user != null && prevValue?.value == null) {
            }
          },
          error: (error, stackTrace) {
            final msg = NetworkExceptions.getErrorMessage(
              error is NetworkExceptions
                  ? error
                  : const NetworkExceptions.unexpectedError(),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(msg)),
            );
          },
          loading: () {},
        );
      },
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: ColorApp.mainWhite,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
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

                  state.profileValue.when(
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) => Column(
                      children: [
                        Text(
                          NetworkExceptions.getErrorMessage(
                            error is NetworkExceptions
                                ? error
                                : const NetworkExceptions.unexpectedError(),
                          ),
                          style: TypographyApp.bodyNormalMedium.copyWith(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        Gap.h16,
                        AppButton(
                          text: 'Coba Lagi',
                          onPressed: () => controller.loadProfile(),
                        ),
                      ],
                    ),
                    data: (user) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: const NetworkImage(
                                  'https://static.wikia.nocookie.net/disney/images/2/28/Profile-_Carl_Fredricksen.png/revision/latest?cb=20210525075534',
                                ),
                                child: state.isEditMode
                                    ? Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                )
                                    : null,
                              ),
                              Gap.h12,
                            ],
                          ),
                        ),
                        Text('Nama', style: TypographyApp.labelSmallMedium),
                        Gap.h16,
                        // Name input field
                        AppTextField(
                          hintText: 'Masukkan nama',
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
                          enabled: state.isEditMode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        Gap.h16,
                        Text('Email', style: TypographyApp.labelSmallMedium),
                        Gap.h12,
                        // Email input field
                        AppTextField(
                          hintText: 'Masukkan email',
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
                          enabled: state.isEditMode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            if (!value.contains('@')) {
                              return 'Email tidak valid';
                            }
                            return null;
                          },
                        ),
                        Gap.h16,
                        Text('Nomor Telepon', style: TypographyApp.labelSmallMedium),
                        Gap.h16,
                        // Phone input field
                        AppTextField(
                          hintText: 'Masukkan nomor telepon',
                          controller: controller.phoneNumberController,
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
                          enabled: state.isEditMode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nomor telepon tidak boleh kosong';
                            }
                            if (value.length < 10) {
                              return 'Nomor telepon terlalu pendek';
                            }
                            return null;
                          },
                          // onChanged: controller.updatePhoneNumber,
                        ),
                        Gap.h32,
                        state.isEditMode
                            ? Column(
                          children: [
                            AppButton(
                              backgroundColor: ColorApp.primary,
                              text: 'Simpan',
                              onPressed: () => controller.updateProfile(),
                            ),
                            Gap.h16,
                            AppButton(
                              backgroundColor: ColorApp.error,
                              text: 'Batal',
                              onPressed: () => controller.cancelEdit(),
                            ),
                          ],
                        )
                            : AppButton(
                          backgroundColor: ColorApp.easy,
                          text: 'Edit',
                          onPressed: () => controller.toggleEditMode(),
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
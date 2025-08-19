import 'package:calisfun/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../widgets/widgets.dart';
import 'child_profile_add_controller.dart';


class ChildProfileAddPage extends ConsumerWidget {
  const ChildProfileAddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(childProfileAddControllerProvider);
    final controller  = ref.read(childProfileAddControllerProvider.notifier);

    return GestureDetector(
      onTap: () {
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
                  Text('Tambah', style: TypographyApp.headingLargeBoldPrimary),
                  Text('Akun Anak', style: TypographyApp.headingLargeBold),
                  Gap.h16,
                  Text('Ayo daftarkan akun anak supaya bisa mulai belajar.', style: TypographyApp.bodyNormalRegular,),
                  Gap.h16,
                  AppTextField(
                    hintText: 'Masukkan nama anak',
                    controller: controller.nameController,
                    validator: controller.validateName,
                    onChanged: controller.onNameChanged,
                    keyboardType: TextInputType.text,
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

                  ),
                  Gap.h16,
                  InkWell(
                    onTap: () {
                      controller.pickImage();
                    },
                    child: Container(
                      height: SizeApp.customHeight(200),
                      decoration: BoxDecoration(
                        color: ColorApp.mainWhite,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: ColorApp.border, width: 1.w),
                      ),
                      child: Center(
                        child: state.imageFile == null
                            ? Image.asset(
                          'assets/images/pick_pics_img.png',
                          width: SizeApp.customWidth(166),
                          height: SizeApp.customHeight(133),
                          fit: BoxFit.cover,
                        )
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.file(
                            state.imageFile!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap.h16,
                  AppButton(
                    text: state.isLoading ? 'Loading' : 'Buat Akun Anak',
                    onPressed: state.canSubmit ? controller.submit : null,
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
import 'package:calisfun/src/constants/constants.dart';
import 'package:calisfun/src/core/presentation/auth/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../widgets/widgets.dart';

class ChatbotPage extends ConsumerWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signupControllerProvider);
    final controller = ref.read(signupControllerProvider.notifier);

    return Scaffold(
      backgroundColor: ColorApp.mainWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap.h80,
            Row(
              children: [
                AppPrevButton(),
                SizedBox(width: 22),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRqUaGFKWrrv_RskYoykH2ONRynGRAAG6F0A&s',
                      ),
                    ),
                    Gap.w12,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Callie', style: TypographyApp.headingSmallBold),
                        Gap.h4,
                        Text(
                          'Teman Belajarmu',
                          style: TypographyApp.labelSmallMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            // ...chat content di sini jika ada...
            Expanded(
              child: Container(), // ganti dengan chat list jika ada
            ),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    hintText: 'Masukan Pertanyaanmu di sini',
                    controller: controller.nameController,
                    keyboardType: TextInputType.name,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: SizeApp.w16,
                      vertical: SizeApp.h12,
                    ),
                    hintStyle: TypographyApp.labelSmallMediumGrey,
                    inputStyle: TypographyApp.labelSmallMedium,
                    validator: controller.validateName,
                    onChanged: controller.onNameChanged,
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  width: SizeApp.w48,
                  height: SizeApp.h48,
                  decoration: BoxDecoration(
                    color: ColorApp.primary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10.r),
                      child: Center(
                        child: Icon(
                          Icons.send_rounded,
                          color: ColorApp.mainWhite,
                          size: SizeApp.w24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap.h16,
          ],
        ),
      ),
    );
  }
}

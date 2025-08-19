import 'package:calisfun/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../widgets/widgets.dart';

class ChildProfilePage extends ConsumerWidget {
  const ChildProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ColorApp.mainWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap.h80,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppPrevButton(),
                Container(
                  width: SizeApp.w48,
                  height: SizeApp.h48,
                  decoration: BoxDecoration(
                    color: ColorApp.secondary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/edit_ic.svg',
                      width: SizeApp.w24,
                      height: SizeApp.h24,
                      colorFilter: const ColorFilter.mode(
                        ColorApp.mainWhite,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap.h16,
            Text('Profile Anak', style: TypographyApp.headingLargeBoldPrimary),
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
                  Text('Zelin', style: TypographyApp.headingLargeBold),
                  Gap.h16,
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Level 78', style: TypographyApp.labelSmallBold),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('31 hari', style: TypographyApp.labelSmallBold),
                    Gap.w4,
                    Image.asset(
                      'assets/images/streak_img.png',
                      width: SizeApp.w24,
                      height: SizeApp.h28,
                    ),
                  ],
                ),
              ],
            ),
            Gap.h8,
            //progress bar color primary, grey
            LinearProgressIndicator(
              minHeight: SizeApp.h16,
              borderRadius: BorderRadius.circular(100.r),
              value: 0.7,
              valueColor: AlwaysStoppedAnimation<Color>(ColorApp.primary),
              backgroundColor: ColorApp.greyInactive,
            ),
            Gap.h8,
            Text('xp 52123', style: TypographyApp.labelSmallBold),
            Gap.h16,
            Text(
              'Progresmu',
              style: TypographyApp.headingSmallBold.copyWith(
                color: ColorApp.primary,
              ),
            ),
            Gap.h16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //make a circle container with image center
                    Container(
                      width: SizeApp.w64,
                      height: SizeApp.w64,
                      decoration: BoxDecoration(
                        color: ColorApp.sage,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/read_img.png',
                          width: SizeApp.w48,
                          height: SizeApp.h48,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Gap.h8,
                    Text('Belajar', style: TypographyApp.bodyNormalMedium),
                    Text('Membaca', style: TypographyApp.bodyNormalMedium),
                    Text('9/10 soal', style: TypographyApp.bodyNormalBold),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //make a circle container with image center
                    Container(
                      width: SizeApp.w64,
                      height: SizeApp.w64,
                      decoration: BoxDecoration(
                        color: ColorApp.primary,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/write_img.png',
                          width: SizeApp.w48,
                          height: SizeApp.h48,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Gap.h8,
                    Text('Belajar', style: TypographyApp.bodyNormalMedium),
                    Text('Menulis', style: TypographyApp.bodyNormalMedium),
                    Text('10/30 soal', style: TypographyApp.bodyNormalBold),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //make a circle container with image center
                    Container(
                      width: SizeApp.w64,
                      height: SizeApp.w64,
                      decoration: BoxDecoration(
                        color: ColorApp.secondary,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/count_img.png',
                          width: SizeApp.w32,
                          height: SizeApp.h36,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Gap.h8,
                    Text('Belajar', style: TypographyApp.bodyNormalMedium),
                    Text('Berhitung', style: TypographyApp.bodyNormalMedium),
                    Text('9/30 soal', style: TypographyApp.bodyNormalBold),
                  ],
                ),
              ],
            ),
            Gap.h56,
            AppButton(
              backgroundColor: ColorApp.error,
              text: 'Hapus',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

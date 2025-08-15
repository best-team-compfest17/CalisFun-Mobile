import 'package:calisfun/src/widgets/app_button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/constants.dart';
import '../../../widgets/widgets.dart';

class HomeParentPage extends ConsumerWidget {
  const HomeParentPage({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Halo, Budi', style: TypographyApp.headingLargeBoldPrimary,),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://picsum.photos/200'),
                ),
              ],
            ),
            Gap.h16,
            Text('Aktivitas Anak', style: TypographyApp.headingLargeBoldPrimary,),
            Gap.h16,
            AppContainer(
              height: SizeApp.h80,
              childLeft: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Zelin', style: TypographyApp.headingSmallBold,),
                  Gap.w8,
                  Text('Level 0', style: TypographyApp.headingSmallMedium,),
                ],
              ),
              childRight: Container(
                width: SizeApp.customWidth(46),
                height: SizeApp.customHeight(46),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                //svg
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/arrow_next_ic.svg',
                    width: SizeApp.w24,
                    height: SizeApp.h24,
                    colorFilter: const ColorFilter.mode(
                      ColorApp.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              showBorder: true,
              showShadow: true,
              backgroundColor: ColorApp.mainWhite,
            ),
            // if-empty
            // Text('Aktivitas Anak', style: TypographyApp.headingLargeBoldPrimary,),
            // Gap.h16,
            // Image.asset('assets/images/parent_empty_img.png', width: SizeApp.customWidth(300), height: SizeApp.customHeight(200),),
            // Gap.h16,
            // Text(
            //   'Belum ada akun anak? Daftarkan sekarang biar bisa mulai.',
            //   style: TypographyApp.bodyNormalMedium,
            //   textAlign: TextAlign.center,
            // ),
            Gap.h24,
            AppButton(text: 'Tambah', onPressed: (){})
          ],
        ),
      ),
    );
  }
}
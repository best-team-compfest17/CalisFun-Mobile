import 'package:calisfun/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CategoryPage extends ConsumerWidget {
  const CategoryPage({super.key});

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
            Container(
              width: SizeApp.w48,
              height: SizeApp.h48,
              decoration: BoxDecoration(
                color: ColorApp.primary,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/arrow_prev_ic.svg',
                  width: SizeApp.w24,
                  height: SizeApp.h24,
                  colorFilter: const ColorFilter.mode(ColorApp.mainWhite, BlendMode.srcIn),
                ),
              ),
            ),
            Gap.h16,
            Text('Pilih', style: TypographyApp.headingLargeBoldPrimary,),
            Text('Jenis', style: TypographyApp.headingLargeBold,),
            Gap.h56,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: SizeApp.customHeight(170),
                  height: SizeApp.customHeight(170),
                  decoration: BoxDecoration(
                    color: ColorApp.amber,
                    borderRadius: BorderRadius.circular(17.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/letter_img.png', width: 100.w, height: 100.h, fit: BoxFit.cover,),
                      Gap.h12,
                      Text('Huruf', style: TypographyApp.headingLargeBold,),
                    ],
                  ),
                ),
                Container(
                  width: SizeApp.customHeight(170),
                  height: SizeApp.customHeight(170),
                  decoration: BoxDecoration(
                    color: ColorApp.purple,
                    borderRadius: BorderRadius.circular(17.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/number_img.png', width: 80.w, height: 104.h, fit: BoxFit.cover,),
                      Gap.h12,
                      Text('Angka', style: TypographyApp.headingLargeBold,),
                    ],
                  ),
                ),
              ],
            ),
            Gap.h36,
            Center(
              child: Container(
                width: SizeApp.customHeight(170),
                height: SizeApp.customHeight(170),
                decoration: BoxDecoration(
                  color: ColorApp.sage,
                  borderRadius: BorderRadius.circular(17.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/word_img.png', width: 126.w, height: 72.h, fit: BoxFit.cover,),
                    Gap.h12,
                    Text('Kata', style: TypographyApp.headingLargeBold,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
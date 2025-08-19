import 'package:calisfun/src/widgets/app_container/app_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../constants/constants.dart';



class DifficultyPage extends ConsumerWidget {
  const DifficultyPage({super.key});

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
                  colorFilter: const ColorFilter.mode(
                    ColorApp.mainWhite,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Gap.h16,
            Text('Pilih', style: TypographyApp.headingLargeBoldPrimary),
            Text('Tingkat Kesulitan', style: TypographyApp.headingLargeBold),
            Gap.h56,
            AppContainer(
              backgroundColor: ColorApp.easy,
              height: SizeApp.h72,
              childLeft: Text(
                'Mudah',
                style: TypographyApp.headingLargeBold.copyWith(
                  color: ColorApp.mainWhite,
                ),
              ),
              childRight: Container(
                width: SizeApp.customWidth(46),
                height: SizeApp.customHeight(46),
                decoration: BoxDecoration(
                  color: ColorApp.mainWhite,
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
            ),
            Gap.h16,
            AppContainer(
              backgroundColor: ColorApp.medium,
              height: SizeApp.h72,
              childLeft: Text(
                'Sedang',
                style: TypographyApp.headingLargeBold.copyWith(
                  color: ColorApp.mainWhite,
                ),
              ),
              childRight: Container(
                width: SizeApp.customWidth(46),
                height: SizeApp.customHeight(46),
                decoration: BoxDecoration(
                  color: ColorApp.mainWhite,
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
            ),
            Gap.h16,
            AppContainer(
              backgroundColor: ColorApp.hard,
              height: SizeApp.h72,
              childLeft: Text(
                'Sulit',
                style: TypographyApp.headingLargeBold.copyWith(
                  color: ColorApp.mainWhite,
                ),
              ),
              childRight: Container(
                width: SizeApp.customWidth(46),
                height: SizeApp.customHeight(46),
                decoration: BoxDecoration(
                  color: ColorApp.mainWhite,
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
            ),
          ],
        ),
      ),
    );
  }
}

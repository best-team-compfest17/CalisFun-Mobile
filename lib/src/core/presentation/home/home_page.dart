import 'package:calisfun/src/routes/routes.dart';
import 'package:calisfun/src/widgets/app_container/app_container.dart';
import 'package:flutter/material.dart';

import 'package:calisfun/src/constants/constants.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ColorApp.mainWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap.h80,
              Text('Halo, Zelin', style: TypographyApp.headingLargeBoldPrimary),
              Gap.h16,
              AppContainer(
                height: SizeApp.customHeight(100),
                backgroundColor: ColorApp.primary,
                childLeft: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tantangan harian',
                      style: TypographyApp.headingSmallMedium.copyWith(
                        color: ColorApp.mainWhite,
                      ),
                    ),
                    Text(
                      'Klik untuk mengerjakan',
                      style: TypographyApp.headingSmallBold.copyWith(
                        color: ColorApp.mainWhite,
                      ),
                    ),
                  ],
                ),
                childRight: Container(
                  width: SizeApp.customWidth(70),
                  height: SizeApp.customHeight(70),
                  decoration: BoxDecoration(
                    color: ColorApp.secondary,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  //svg
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/question_ic.svg',
                      width: SizeApp.w24,
                      height: SizeApp.h40,
                      colorFilter: const ColorFilter.mode(
                        ColorApp.mainWhite,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              Gap.h16,
              Text(
                'Mau belajar apa?',
                style: TypographyApp.headingLargeBoldPrimary,
              ),
              Gap.h16,
              InkWell(
                onTap: () => context.pushNamed(Routes.learnSpell.name),
                child: AppContainer(
                  backgroundColor: ColorApp.sage,
                  childLeft: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Belajar',
                        style: TypographyApp.headingLargeBold.copyWith(
                          color: ColorApp.mainWhite,
                        ),
                      ),
                      Text(
                        'Membaca',
                        style: TypographyApp.headingLargeBold.copyWith(
                          color: ColorApp.mainWhite,
                        ),
                      ),
                    ],
                  ),
                  childRight: Image.asset(
                    'assets/images/read_img.png',
                    width: SizeApp.customWidth(111),
                    height: SizeApp.customHeight(92),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Gap.h16,
              InkWell(
                onTap: () => context.pushNamed(Routes.category.name),
                child: AppContainer(
                  backgroundColor: ColorApp.primary,
                  childLeft: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Belajar',
                        style: TypographyApp.headingLargeBold.copyWith(
                          color: ColorApp.mainWhite,
                        ),
                      ),
                      Text(
                        'Menulis',
                        style: TypographyApp.headingLargeBold.copyWith(
                          color: ColorApp.mainWhite,
                        ),
                      ),
                    ],
                  ),
                  childRight: Image.asset(
                    'assets/images/write_img.png',
                    width: SizeApp.customWidth(111),
                    height: SizeApp.customHeight(92),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Gap.h16,
              InkWell(
                onTap: () => context.pushNamed(Routes.learnWrite.name),
                child: AppContainer(
                  backgroundColor: ColorApp.secondary,
                  childLeft: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Belajar',
                        style: TypographyApp.headingLargeBold.copyWith(
                          color: ColorApp.mainWhite,
                        ),
                      ),
                      Text(
                        'Menghitung',
                        style: TypographyApp.headingLargeBold.copyWith(
                          color: ColorApp.mainWhite,
                        ),
                      ),
                    ],
                  ),
                  childRight: Image.asset(
                    'assets/images/count_img.png',
                    width: SizeApp.customWidth(60),
                    height: SizeApp.customHeight(72),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

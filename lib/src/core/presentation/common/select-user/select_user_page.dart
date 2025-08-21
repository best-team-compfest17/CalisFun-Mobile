import 'package:calisfun/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/routes.dart';

class SelectUserPage extends ConsumerWidget {
  const SelectUserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ColorApp.whiteBlue,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: SizeApp.customHeight(500),
              decoration: BoxDecoration(
                color: ColorApp.darkBlue,
                image: DecorationImage(
                  image: AssetImage('assets/images/stars_img.png'),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(190.r),
                  bottomRight: Radius.circular(190.r),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/calisfun_logo.png',
                      width: SizeApp.customWidth(150),
                      height: SizeApp.customHeight(150),
                    ),
                    Text(
                      'CalisFun',
                      style: TypographyApp.headingLargeBold.copyWith(
                        color: ColorApp.mainWhite,
                      ),
                    ),
                    Gap.h8,
                    Text(
                      'Fun Way to Read, Write, Count',
                      style: TypographyApp.headingSmallMedium.copyWith(
                        color: ColorApp.mainWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap.h32,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Pilih Pengguna',
                      style: TypographyApp.headingSmallBold.copyWith(
                        color: ColorApp.mainWhite,
                      ),
                    ),
                  ),
                  Gap.h8,
                  Center(
                    child: Text(
                      'Pilih pengguna untuk masuk',
                      style: TypographyApp.bodyNormalMedium.copyWith(
                        color: ColorApp.mainWhite,
                      ),
                    ),
                  ),
                  Gap.h16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => context.goNamed(Routes.homeParent.name),
                        child: Container(
                          width: SizeApp.customWidth(160),
                          height: SizeApp.customHeight(150),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: ColorApp.mainWhite,
                              width: 3,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/select_parent_ic.svg',
                                width: SizeApp.w40,
                                height: SizeApp.h40,
                                colorFilter: const ColorFilter.mode(
                                  ColorApp.mainWhite,
                                  BlendMode.srcIn,
                                ),
                              ),
                              Gap.h8,
                              Text(
                                'Orang Tua',
                                style: TypographyApp.headingSmallRegular.copyWith(
                                  color: ColorApp.mainWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => context.goNamed(Routes.selectChild.name),
                        child: Container(
                          width: SizeApp.customWidth(160),
                          height: SizeApp.customHeight(150),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: ColorApp.mainWhite,
                              width: 3,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/select_child_img.png',
                                width: SizeApp.w40,
                                height: SizeApp.h40,
                              ),
                              Gap.h8,
                              Text(
                                'Anak',
                                style: TypographyApp.headingSmallRegular.copyWith(
                                  color: ColorApp.mainWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
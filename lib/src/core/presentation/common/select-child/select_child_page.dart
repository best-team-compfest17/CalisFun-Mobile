import 'package:calisfun/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/routes.dart';

class SelectChildPage extends ConsumerWidget{
  const SelectChildPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ColorApp.darkBlue,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap.h80,
            Text('Halo, Anak', style: TypographyApp.headingLargeBold.copyWith(color: ColorApp.mainWhite),),
            Text('Siap untuk belajar', style: TypographyApp.headingLargeBold.copyWith(color: ColorApp.greyInactive),),
            Gap.h16,
            Text('Siap memulai? Pilih namanya dulu, yuk!', style: TypographyApp.bodyNormalRegular.copyWith(color: ColorApp.greyInactive),),
            Gap.h16,
            InkWell(
              onTap: () {
                context.goNamed(Routes.botnavbar.name);
              },
              child: Container(
                height: SizeApp.h52,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: ColorApp.mainWhite,
                    width: 1.w,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Andi',
                    style: TypographyApp.bodyNormalRegular.copyWith(color: ColorApp.mainWhite),
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
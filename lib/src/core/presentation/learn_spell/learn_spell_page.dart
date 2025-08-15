import 'package:calisfun/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/widgets.dart';

class LearnSpellPage extends ConsumerWidget {
  const LearnSpellPage({super.key});

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
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: ColorApp.mainWhite),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            Gap.h16,
            LinearProgressIndicator(
              minHeight: SizeApp.h16,
              borderRadius: BorderRadius.circular(100.r),
              value: 0.1,
              valueColor: AlwaysStoppedAnimation<Color>(ColorApp.primary),
              backgroundColor: ColorApp.greyInactive,
            ),
            Gap.h16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Kata 1 dari 10', style: TypographyApp.headingSmallBold),
                Text(
                  '',
                  style: TypographyApp.headingSmallBold.copyWith(
                    color: ColorApp.success,
                  ),
                ),
              ],
            ),
            Gap.h16,
            Container(
              width: SizeApp.customWidth(360),
              height: SizeApp.customHeight(200),
              decoration: BoxDecoration(
                color: ColorApp.primary,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Text(
                  'JERAPAH',
                  style: TypographyApp.headingLargeBold.copyWith(
                    color: ColorApp.mainWhite,
                  ),
                ),
              ),
            ),
            Gap.h16,
            Text(
              'Merekam',
              style: TypographyApp.headingSmallBold.copyWith(color: ColorApp.primary),
            ),
            // recording image here
            Gap.h56,
            Container(
              width: SizeApp.customWidth(360),
              height: SizeApp.customHeight(74),
              decoration: BoxDecoration(
                color: ColorApp.greyInactive,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.mic, color: ColorApp.error, size: SizeApp.h24),
                  Gap.w8,
                  Text(
                    'Tekan untuk berbicara',
                    style: TypographyApp.bodyNormalRegular.copyWith(color: ColorApp.error),
                  ),
                ],
              ),
            ),
            Gap.h16,
            AppButton(
              text: 'Periksa',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
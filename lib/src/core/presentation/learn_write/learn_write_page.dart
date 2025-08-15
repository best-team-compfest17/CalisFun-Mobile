import 'package:calisfun/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/widgets.dart';

class LearnWritePage extends ConsumerWidget {
  const LearnWritePage({super.key});

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
            Gap.h40,
            Center(
              child: Text(
                'JERAPAH',
                style: TypographyApp.headingLargeBold,
                textAlign: TextAlign.center,
              ),
            ),
            Gap.h40,
            Text(
              'Tuliskan kata ini di papan tulis di bawah',
              style: TypographyApp.bodyNormalRegular,
            ),
            Gap.h16,
            Container(
              height: SizeApp.customHeight(360),
              decoration: BoxDecoration(
                color: ColorApp.greyInactive,
                borderRadius: BorderRadius.circular(10.r),
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

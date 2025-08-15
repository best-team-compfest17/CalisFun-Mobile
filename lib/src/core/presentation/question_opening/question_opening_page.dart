import 'package:calisfun/src/constants/constants.dart';
import 'package:calisfun/src/widgets/app_button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionOpeningPage extends ConsumerWidget {
  const QuestionOpeningPage({super.key});
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
            Text('Belajar', style: TypographyApp.headingLargeBoldPrimary),
            Text('Menulis', style: TypographyApp.headingLargeBold),
            Gap.h80,
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/help_write_img.png', width: SizeApp.customWidth(175), height: SizeApp.customHeight(175), ),
                  Text('Halo Zelin, aku butuh bantuan nih. Bisa bantu aku dalam menulis?', style: TypographyApp.headingLargeMedium,  textAlign: TextAlign.center,),
                ],
              ),
            ),
            Gap.h80,
            AppButton(text: 'Mulai', onPressed: (){}),
          ],
        ),
      ),
    );
  }
}

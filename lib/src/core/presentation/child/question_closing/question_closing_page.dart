import 'package:calisfun/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../widgets/widgets.dart';

class QuestionClosingPage extends ConsumerWidget{
  const QuestionClosingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ColorApp.mainWhite,
      body: Padding(padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/images/learn_write_closing_img.png', width: SizeApp.customWidth(175), height:  SizeApp.customHeight(175), fit: BoxFit.cover,)),
          Text('Terima kasih, Zelin! Kamu sudah membantuku menulis.', style: TypographyApp.headingLargeMedium, textAlign: TextAlign.center,),
          Gap.h80,
          AppButton(text: 'Kembali ke Beranda', onPressed: (){}),
        ],
      ),),
    );
  }
}
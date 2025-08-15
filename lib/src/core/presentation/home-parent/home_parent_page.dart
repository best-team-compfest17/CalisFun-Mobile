import 'package:calisfun/src/widgets/app_button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';

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
            Image.asset('assets/images/parent_empty_img.png', width: SizeApp.customWidth(300), height: SizeApp.customHeight(200),),
            Gap.h16,
            Text(
              'Belum ada akun anak? Daftarkan sekarang biar bisa mulai.',
              style: TypographyApp.bodyNormalMedium,
              textAlign: TextAlign.center,
            ),
            Gap.h24,
            AppButton(text: 'Tambah', onPressed: (){})
          ],
        ),
      ),
    );
  }
}
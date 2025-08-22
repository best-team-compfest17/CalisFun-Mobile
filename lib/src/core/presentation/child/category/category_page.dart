import 'package:calisfun/src/constants/constants.dart';
import 'package:calisfun/src/widgets/app_prev_button/app_prev_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/routes.dart';
import '../../../application/child_by_id_provider.dart';
import '../../../application/selected_child_provider.dart';

class CategoryPage extends ConsumerWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedChildIdProvider);
    if (selectedId == null) {
      return const SizedBox.shrink();
    }

    final childAsync = ref.watch(childByIdProvider(selectedId));

    void goToWrite(WritingCategory category) {
      final id = selectedId;
      context.pushNamed(
        Routes.learnWrite.name,
        extra: (childId: id, category: category),
      );
    }


    return childAsync.when(data: (child){
      return Scaffold(
        backgroundColor: ColorApp.mainWhite,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap.h80,
              const AppPrevButton(),
              Gap.h16,
              Text('Pilih', style: TypographyApp.headingLargeBoldPrimary),
              Text('Jenis', style: TypographyApp.headingLargeBold),
              Gap.h56,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // HURUF
                  InkWell(
                    onTap: () => goToWrite(WritingCategory.letter),
                    child: Container(
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
                          Image.asset(
                            'assets/images/letter_img.png',
                            width: 100.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                          ),
                          Gap.h12,
                          Text('Huruf', style: TypographyApp.headingLargeBold),
                        ],
                      ),
                    ),
                  ),
                  // ANGKA
                  InkWell(
                    onTap: () => goToWrite(WritingCategory.number),
                    child: Container(
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
                          Image.asset(
                            'assets/images/number_img.png',
                            width: 80.w,
                            height: 104.h,
                            fit: BoxFit.cover,
                          ),
                          Gap.h12,
                          Text('Angka', style: TypographyApp.headingLargeBold),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Gap.h36,
              Center(
                child: InkWell(
                  onTap: () => goToWrite(WritingCategory.word),
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
                        Image.asset(
                          'assets/images/word_img.png',
                          width: 126.w,
                          height: 72.h,
                          fit: BoxFit.cover,
                        ),
                        Gap.h12,
                        Text('Kata', style: TypographyApp.headingLargeBold),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
    loading: () => const Center(child: CircularProgressIndicator()),
    error: (err, st) => Center(child: Text('Gagal memuat anak: $err')),);
  }
}
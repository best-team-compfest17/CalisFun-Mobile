import 'package:calisfun/src/constants/constants.dart';
import 'package:calisfun/src/widgets/app_ink_painter/app_ink_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/widgets.dart';
import 'learn_write_controller.dart';

class LearnWritePage extends ConsumerWidget {
  const LearnWritePage({
    super.key,
    required this.childId,
    required this.category,
  });

  final String childId;
  final WritingCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = (childId: childId, category: category);
    final state = ref.watch(learnWriteProvider(params));
    final c = ref.read(learnWriteProvider(params).notifier);

    String catLabel;
    switch (category) {
      case WritingCategory.word:   catLabel = 'Kata';  break;
      case WritingCategory.letter: catLabel = 'Huruf'; break;
      case WritingCategory.number: catLabel = 'Angka'; break;
    }

    if (state.loading) {
      return Scaffold(
        backgroundColor: ColorApp.mainWhite,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: ColorApp.primary),
              Gap.h16,
              Text('Memuat soal berikutnya...', style: TypographyApp.bodyNormalRegular),
            ],
          ),
        ),
      );
    }

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
                Text('$catLabel ${state.level ?? '-'} dari 10', style: TypographyApp.headingSmallBold),
                Text(
                  state.posting ? 'Menyimpan…' : state.status,
                  style: TypographyApp.bodyNormalRegular.copyWith(
                    color: state.posting ? ColorApp.secondary :
                    state.status.contains('BENAR') ? ColorApp.success :
                    state.status.contains('Error') ? ColorApp.error : Colors.black,
                  ),
                ),
              ],
            ),
            Gap.h40,
            Center(
              child: Text(
                state.target.isNotEmpty ? state.target : '...',
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
            // Canvas
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorApp.greyInactive,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanStart: (d) => c.startStroke(d.localPosition),
                  onPanUpdate: (d) => c.updateStroke(d.localPosition),
                  onPanEnd: (_) => c.endStroke(),
                  child: InkCanvas(
                    strokes: state.strokes,
                    currentStroke: state.currentStroke,
                    strokeColor: Colors.black,
                    strokeWidth: 6,
                  ),
                ),
              ),
            ),
            Gap.h16,
            if (state.lastResult != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(SizeApp.w12),
                decoration: BoxDecoration(
                  color: state.lastResult!.contains('BENAR') ? ColorApp.success.withValues(alpha: 0.2) : Colors.black12,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  state.lastResult!,
                  style: TypographyApp.bodyNormalRegular.copyWith(
                    color: state.lastResult!.contains('BENAR') ? ColorApp.success : Colors.black,
                  ),
                ),
              ),
            Gap.h12,
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: 'Undo',
                    onPressed: c.undo,
                    backgroundColor: ColorApp.secondary,
                  ),
                ),
                Gap.w12,
                Expanded(
                  child: AppButton(
                    text: 'Periksa',
                    onPressed: (state.modelReady &&
                        !state.posting &&
                        !state.loading &&
                        state.target.isNotEmpty)
                        ? c.check
                        : null,
                  ),
                ),
              ],
            ),
            Gap.h16,
          ],
        ),
      ),
    );
  }
}

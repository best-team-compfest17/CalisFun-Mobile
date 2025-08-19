import 'package:calisfun/src/constants/constants.dart';
import 'package:calisfun/src/widgets/app_ink_painter/app_ink_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/widgets.dart';
import 'learn_write_controller.dart';

class LearnWritePage extends ConsumerWidget {
  const LearnWritePage({super.key});

  static const String targetWord = 'A';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(learnWriteProvider);
    final controller = ref.read(learnWriteProvider.notifier);

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
                // tampilkan status kecil di kanan
                Text(
                  state.status,
                  style: TypographyApp.bodyNormalRegular.copyWith(
                    color: ColorApp.success,
                  ),
                ),
              ],
            ),
            Gap.h40,
            Center(
              child: Text(
                targetWord,
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
                  onPanStart: (d) => controller.startStroke(d.localPosition),
                  onPanUpdate: (d) => controller.updateStroke(d.localPosition),
                  onPanEnd: (_) => controller.endStroke(),
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
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  state.lastResult!,
                  style: TypographyApp.bodyNormalRegular,
                ),
              ),
            Gap.h12,
            Row(
              children: [
                Expanded(
                  child: AppButton(text: 'Undo', onPressed: controller.undo, backgroundColor: ColorApp.secondary,),
                ),
                Gap.w12,
                Gap.w12,
                Expanded(
                  child: AppButton(
                    text: 'Periksa',
                    onPressed:
                        state.modelReady
                            ? () => controller.check(targetWord)
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

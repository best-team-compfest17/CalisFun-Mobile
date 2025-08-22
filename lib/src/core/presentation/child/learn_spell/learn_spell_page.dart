import 'package:calisfun/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/widgets.dart';
import '../../../application/reading_provider.dart';
import 'learn_spell_controller.dart';

class LearnSpellPage extends ConsumerStatefulWidget {
  const LearnSpellPage({super.key, required this.childId});
  final String childId;

  @override
  ConsumerState<LearnSpellPage> createState() => _LearnSpellPageState();
}

class _LearnSpellPageState extends ConsumerState<LearnSpellPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(speechProvider.notifier).init());
  }

  @override
  Widget build(BuildContext context) {
    final speech = ref.watch(speechProvider);
    final ctrl = ref.read(speechProvider.notifier);

    final asyncQuestion = ref.watch(readingQuestionProvider(widget.childId));

    return Scaffold(
      backgroundColor: ColorApp.mainWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
        child: asyncQuestion.when(
          loading: () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap.h80,
              const AppPrevButton(),
              Gap.h16,
              const LinearProgressIndicator(),
              Gap.h16,
              Text('Memuat soal...', style: TypographyApp.headingSmallBold),
            ],
          ),
          error: (err, st) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap.h80,
              const AppPrevButton(),
              Gap.h16,
              Text(
                'Gagal memuat soal: $err',
                style: TypographyApp.headingSmallBold.copyWith(color: ColorApp.error),
              ),
              Gap.h16,
              AppButton(
                text: 'Coba Lagi',
                onPressed: () => ref.refresh(readingQuestionProvider(widget.childId)),
              ),
            ],
          ),
          data: (q) {
            final targetWord = (q.word).toUpperCase();
            final bool isCorrect = ctrl.isMatch(targetWord);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap.h80,
                const AppPrevButton(),
                Gap.h16,
                LinearProgressIndicator(
                  minHeight: SizeApp.h16,
                  borderRadius: BorderRadius.circular(100.r),
                  value: 0.1,
                  valueColor: const AlwaysStoppedAnimation<Color>(ColorApp.primary),
                  backgroundColor: ColorApp.greyInactive,
                ),
                Gap.h16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Kata ${q.level} dari 10', style: TypographyApp.headingSmallBold),
                    Text(
                      speech.words.isEmpty ? '' : (isCorrect ? 'Benar!' : 'Coba lagi'),
                      style: TypographyApp.headingSmallBold.copyWith(
                        color: isCorrect ? ColorApp.success : ColorApp.error,
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
                      targetWord,
                      style: TypographyApp.headingLargeBold.copyWith(
                        color: ColorApp.mainWhite,
                      ),
                    ),
                  ),
                ),
                Gap.h8,
                Text(
                  'Kategori: ${q.category} • Level: ${q.level}',
                  style: TypographyApp.bodyNormalRegular.copyWith(color: ColorApp.greyInactive),
                ),
                Gap.h16,
                Text(
                  speech.listening ? 'Merekam...' : 'Hasil',
                  style: TypographyApp.headingSmallBold.copyWith(color: ColorApp.primary),
                ),
                Gap.h8,
                Container(
                  width: SizeApp.customWidth(360),
                  padding: EdgeInsets.all(SizeApp.w12),
                  decoration: BoxDecoration(
                    color: ColorApp.greyInactive.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    speech.words.isEmpty
                        ? (speech.available
                        ? (speech.listening ? 'Mendengarkan...' : 'Belum ada hasil.')
                        : 'Pengenalan suara tidak tersedia di perangkat ini.')
                        : speech.words,
                    style: TypographyApp.bodyNormalRegular,
                  ),
                ),
                Gap.h24,
                GestureDetector(
                  onTap: () => ctrl.toggle(localeId: 'id_ID'),
                  child: Container(
                    width: SizeApp.customWidth(360),
                    height: SizeApp.customHeight(74),
                    decoration: BoxDecoration(
                      color: speech.listening
                          ? ColorApp.error.withValues(alpha: 0.1)
                          : ColorApp.greyInactive,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: speech.listening ? ColorApp.error : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          speech.listening ? Icons.mic : Icons.mic_none,
                          color: ColorApp.error,
                          size: SizeApp.h24,
                        ),
                        Gap.w8,
                        Text(
                          speech.listening ? 'Berbicara sekarang...' : 'Tekan untuk berbicara',
                          style: TypographyApp.bodyNormalRegular.copyWith(
                            color: ColorApp.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap.h16,
                AppButton(
                  text: 'Periksa',
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);

                    final ctrl = ref.read(speechProvider.notifier);
                    final result = await ctrl.checkAndSubmitProgress(
                      childId: widget.childId,
                      questionId: q.id,
                      targetWord: q.word.toUpperCase(),
                    );

                    if (!context.mounted) return;

                    switch (result) {
                      case SpellCheckResult.incorrect:
                        messenger.showSnackBar(
                          SnackBar(
                            content: const Text('Hmm, belum pas. Coba ulangi lagi ya.'),
                            backgroundColor: ColorApp.error,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        break;
                      case SpellCheckResult.success:
                        messenger.showSnackBar(
                          SnackBar(
                            content: Text('Hebat! Progress tersimpan. (${q.word})'),
                            backgroundColor: ColorApp.success,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        ref.invalidate(readingQuestionProvider(widget.childId));
                        break;
                      case SpellCheckResult.failed:
                        messenger.showSnackBar(
                          SnackBar(
                            content: const Text('Benar, tapi gagal menyimpan progress. Coba lagi.'),
                            backgroundColor: ColorApp.error,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        break;
                    }
                  },
                ),
                if (speech.confidence > 0) ...[
                  Gap.h8,
                  Text(
                    'Confidence: ${(speech.confidence * 100).toStringAsFixed(0)}%',
                    style: TypographyApp.bodyNormalRegular.copyWith(color: ColorApp.greyInactive),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

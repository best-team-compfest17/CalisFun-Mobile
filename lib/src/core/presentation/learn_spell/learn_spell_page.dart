import 'package:calisfun/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/widgets.dart';
import 'learn_spell_controller.dart';

class LearnSpellPage extends ConsumerStatefulWidget {
  const LearnSpellPage({super.key});

  @override
  ConsumerState<LearnSpellPage> createState() => _LearnSpellPageState();
}

class _LearnSpellPageState extends ConsumerState<LearnSpellPage> {
  // Ganti sesuai kebutuhan
  bool isLetterMode = true; // true = mode huruf, false = mode kata
  static const String targetWord = 'JERAPAH';
  static const String targetLetter = 'A';

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(speechProvider.notifier).init());
  }

  @override
  Widget build(BuildContext context) {
    final speech = ref.watch(speechProvider);
    final ctrl = ref.read(speechProvider.notifier);

    // Penilaian
    final bool isCorrect = isLetterMode
        ? ctrl.matchesLetter(targetLetter)
        : ctrl.isMatch(targetWord);

    final String targetDisplay = isLetterMode ? targetLetter : targetWord;

    return Scaffold(
      backgroundColor: ColorApp.mainWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap.h80,
            // Back
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

            // Progress
            LinearProgressIndicator(
              minHeight: SizeApp.h16,
              borderRadius: BorderRadius.circular(100.r),
              value: 0.1,
              valueColor: AlwaysStoppedAnimation<Color>(ColorApp.primary),
              backgroundColor: ColorApp.greyInactive,
            ),
            Gap.h16,

            // Header + status benar/salah
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kata 1 dari 10',
                  style: TypographyApp.headingSmallBold,
                ),
                Text(
                  speech.words.isEmpty ? '' : (isCorrect ? 'Benar!' : 'Coba lagi'),
                  style: TypographyApp.headingSmallBold.copyWith(
                    color: isCorrect ? ColorApp.success : ColorApp.error,
                  ),
                ),
              ],
            ),
            Gap.h8,

            // Toggle mode Kata/Huruf
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: SizeApp.w12, vertical: SizeApp.h8),
                  decoration: BoxDecoration(
                    color: ColorApp.greyInactive.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Mode: ${isLetterMode ? 'Huruf' : 'Kata'}',
                        style: TypographyApp.bodyNormalRegular.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Switch(
                        value: isLetterMode,
                        onChanged: (v) {
                          setState(() => isLetterMode = v);
                          // reset hasil agar tidak rancu saat pindah mode
                          ctrl.cancel();
                        },
                        activeColor: ColorApp.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap.h16,

            // Kartu target
            Container(
              width: SizeApp.customWidth(360),
              height: SizeApp.customHeight(200),
              decoration: BoxDecoration(
                color: ColorApp.primary,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Text(
                  targetDisplay,
                  style: TypographyApp.headingLargeBold.copyWith(
                    color: ColorApp.mainWhite,
                  ),
                ),
              ),
            ),
            Gap.h16,

            // Label status
            Text(
              speech.listening ? 'Merekam...' : 'Hasil',
              style: TypographyApp.headingSmallBold.copyWith(color: ColorApp.primary),
            ),
            Gap.h8,

            // Area hasil rekaman
            Container(
              width: SizeApp.customWidth(360),
              padding: EdgeInsets.all(SizeApp.w12),
              decoration: BoxDecoration(
                color: ColorApp.greyInactive.withOpacity(0.5),
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

            // Tombol mic
            GestureDetector(
              onTap: () {
                if (isLetterMode) {
                  // disetel untuk huruf (durasi & jeda lebih panjang)
                  ctrl.startForLetter(localeId: 'id_ID');
                } else {
                  // mode kata biasa
                  ctrl.toggle(localeId: 'id_ID');
                }
              },
              child: Container(
                width: SizeApp.customWidth(360),
                height: SizeApp.customHeight(74),
                decoration: BoxDecoration(
                  color: speech.listening ? ColorApp.error.withOpacity(0.1) : ColorApp.greyInactive,
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

            // Tombol Periksa
            AppButton(
              text: 'Periksa',
              onPressed: () {
                final ok = isLetterMode
                    ? ctrl.matchesLetter(targetLetter)
                    : ctrl.isMatch(targetWord);

                final msg = isLetterMode
                    ? (ok
                    ? 'Mantap! Kamu menyebut huruf $targetLetter dengan benar.'
                    : 'Belum pas. Coba ucapkan huruf $targetLetter lagi ya.')
                    : (ok
                    ? 'Hebat! Kamu mengucapkan "$targetWord" dengan benar.'
                    : 'Hmm, belum pas. Coba ulangi lagi ya.');

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(msg),
                    backgroundColor: ok ? ColorApp.success : ColorApp.error,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
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
        ),
      ),
    );
  }
}

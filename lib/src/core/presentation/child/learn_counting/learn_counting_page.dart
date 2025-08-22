import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../constants/constants.dart';
import '../../../../widgets/widgets.dart';
import 'learn_counting_controller.dart';
import 'learn_counting_state.dart';

class LearnCountingPage extends ConsumerStatefulWidget {
  final Difficulty initialDifficulty;
  final String? childId;

  const LearnCountingPage({
    super.key,
    required this.initialDifficulty,
    this.childId,
  });

  @override
  ConsumerState<LearnCountingPage> createState() => _LearnCountingPageState();
}

class _LearnCountingPageState extends ConsumerState<LearnCountingPage> {
  bool _showingTimeoutDialog = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(learnCountingControllerProvider);
    final controller = ref.read(learnCountingControllerProvider.notifier);

    final inited = ref.watch(
      learnCountingControllerProvider.select((s) => s.initialized),
    );
    if (!inited) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.initIfNeeded(
          difficulty: widget.initialDifficulty,
          childId: widget.childId,
          total: 10,
        );
      });
    }

    ref.listen<LearnCountingState>(learnCountingControllerProvider, (prev, next) {
      final justTimedOut = next.timeUp && !(prev?.timeUp ?? false);
      if (justTimedOut && !_showingTimeoutDialog) {
        _showingTimeoutDialog = true;
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (!mounted) return;
          await _showTimeUpDialog();
          _showingTimeoutDialog = false;
          if (!mounted) return;
          controller.handleExit();
          if (Navigator.of(context).canPop()) Navigator.of(context).pop();
        });
      }
    });

    ref.listen<LearnCountingState>(
      learnCountingControllerProvider.select((s) => s),
          (prev, next) {
        final justPromoted =
            next.promotionDone && !(prev?.promotionDone ?? false);
        if (justPromoted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            controller.handleExit();
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          });
        }
      },
    );


    final total = state.questions.length == 0 ? 10 : state.questions.length;
    final index1 = state.questions.isEmpty ? 1 : (state.currentIndex + 1);
    final rightLabel = state.lastAnswerCorrect == null
        ? _label(widget.initialDifficulty)
        : (state.lastAnswerCorrect! ? 'Benar' : 'Coba lagi');
    final rightColor = state.lastAnswerCorrect == null
        ? ColorApp.success
        : (state.lastAnswerCorrect! ? ColorApp.success : ColorApp.error);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async {
          controller.handleExit();
          return true;
        },
        child: Scaffold(
          backgroundColor: ColorApp.mainWhite,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap.h32,
                          const AppPrevButton(),
                          Gap.h16,
                          LinearProgressIndicator(
                            minHeight: SizeApp.h16,
                            borderRadius: BorderRadius.circular(100.r),
                            value: state.progress,
                            valueColor: const AlwaysStoppedAnimation<Color>(ColorApp.primary),
                            backgroundColor: ColorApp.greyInactive,
                          ),
                          Gap.h16,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Kata $index1 dari $total',
                                style: TypographyApp.headingSmallBold,
                              ),
                              Text(
                                rightLabel,
                                style: TypographyApp.headingSmallBold.copyWith(color: rightColor),
                              ),
                            ],
                          ),
                          Gap.h16,
                          Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: SizeApp.w12, vertical: SizeApp.w12),
                              width: SizeApp.customWidth(190),
                              decoration: BoxDecoration(
                                color: ColorApp.secondary,
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/timer_ic.svg',
                                    width: SizeApp.w24,
                                    height: SizeApp.h24,
                                    colorFilter: const ColorFilter.mode(
                                      ColorApp.mainWhite,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  Gap.w8,
                                  Text('${state.remainingSeconds} detik', style: TypographyApp.headingLargeBold.copyWith(color: ColorApp.mainWhite),),
                                ],
                              ),

                            ),
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
                                state.currentQuestion?.display ?? '1+19+20 = ?',
                                style: TypographyApp.headingLargeBold.copyWith(
                                  color: ColorApp.mainWhite,
                                ),
                              ),
                            ),
                          ),
                          Gap.h16,
                          AppTextField(
                            hintText: 'Masukan jawabanmu disini',
                            controller: controller.answerController, // <- controller jawaban
                            obscureText: false, // jangan disembunyikan
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: SizeApp.w16,
                              vertical: SizeApp.h12,
                            ),
                            hintStyle: TypographyApp.labelSmallMediumGrey,
                            inputStyle: TypographyApp.labelSmallMedium,
                            keyboardType: const TextInputType.numberWithOptions(),
                            // kalau AppTextField mendukung onChanged:
                            onChanged: controller.updateInput,
                          ),
                          Gap.h16,
                        ],
                      ),
                    ),
                  ),
                  AppButton(
                    text: 'Periksa',
                    onPressed: state.finished ? null : controller.submit, // submit jawaban
                  ),
                  Gap.h16,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _label(Difficulty d) => switch (d) {
    Difficulty.easy => 'Mudah',
    Difficulty.medium => 'Sedang',
    Difficulty.hard => 'Sulit',
  };

  Future<void> _showTimeUpDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Waktu habis!'),
        content: const Text('Sayang sekali, waktumu sudah habis.'),
        actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
      ),
    );
  }
}

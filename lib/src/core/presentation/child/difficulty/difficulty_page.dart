import 'package:calisfun/src/widgets/app_container/app_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../constants/constants.dart';

import '../../../../routes/routes.dart';
import '../../../application/child_by_id_provider.dart';
import '../../../application/selected_child_provider.dart';

class DifficultyPage extends ConsumerWidget {
  const DifficultyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedChildIdProvider);
    if (selectedId == null) {
      return const Scaffold(body: Center(child: Text('Pilih profil anak terlebih dahulu')));
    }

    final childAsync = ref.watch(childByIdProvider(selectedId));

    return childAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Gagal memuat anak: $e'))),
      data: (child) {
        // tentukan akses berdasarkan countingDifficulty dari backend
        final base = _difficultyFromBackend(child.countingDifficulty);
        bool can(Difficulty d) => _isUnlocked(base, d);

        // handler umum untuk setiap tap
        void handleTap(Difficulty d) {
          if (can(d)) {
            context.pushNamed(
              Routes.learnCounting.name,
              extra: {'difficulty': d, 'childId': selectedId},
            );
          } else {
            _showLockedDialog(context, d);
          }
        }

        return Scaffold(
          backgroundColor: ColorApp.mainWhite,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap.h80,
                // tombol kembali (biarkan tampilan sama; optional: tambahkan onTap)
                GestureDetector(
                  onTap: () => Navigator.of(context).maybePop(),
                  child: Container(
                    width: SizeApp.w48,
                    height: SizeApp.h48,
                    decoration: BoxDecoration(
                      color: ColorApp.primary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/arrow_prev_ic.svg',
                        width: SizeApp.w24,
                        height: SizeApp.h24,
                        colorFilter: const ColorFilter.mode(
                          ColorApp.mainWhite,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
                Gap.h16,
                Text('Pilih', style: TypographyApp.headingLargeBoldPrimary),
                Text('Tingkat Kesulitan', style: TypographyApp.headingLargeBold),
                Gap.h56,

                // === MUDAH ===
                GestureDetector(
                  onTap: () => handleTap(Difficulty.easy),
                  child: AppContainer(
                    backgroundColor: ColorApp.easy,
                    height: SizeApp.h72,
                    childLeft: Text(
                      'Mudah',
                      style: TypographyApp.headingLargeBold.copyWith(color: ColorApp.mainWhite),
                    ),
                    childRight: _arrowCircle(),
                  ),
                ),
                Gap.h16,

                // === SEDANG ===
                GestureDetector(
                  onTap: () => handleTap(Difficulty.medium),
                  child: AppContainer(
                    backgroundColor: ColorApp.medium,
                    height: SizeApp.h72,
                    childLeft: Text(
                      'Sedang',
                      style: TypographyApp.headingLargeBold.copyWith(color: ColorApp.mainWhite),
                    ),
                    childRight: _arrowCircle(),
                  ),
                ),
                Gap.h16,

                // === SULIT ===
                GestureDetector(
                  onTap: () => handleTap(Difficulty.hard),
                  child: AppContainer(
                    backgroundColor: ColorApp.hard,
                    height: SizeApp.h72,
                    childLeft: Text(
                      'Sulit',
                      style: TypographyApp.headingLargeBold.copyWith(color: ColorApp.mainWhite),
                    ),
                    childRight: _arrowCircle(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // === helpers UI kecil ===
  Widget _arrowCircle() {
    return Container(
      width: SizeApp.customWidth(46),
      height: SizeApp.customHeight(46),
      decoration: BoxDecoration(
        color: ColorApp.mainWhite,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/arrow_next_ic.svg',
          width: SizeApp.w24,
          height: SizeApp.h24,
          colorFilter: const ColorFilter.mode(ColorApp.primary, BlendMode.srcIn),
        ),
      ),
    );
  }

  // === logic akses ===
  Difficulty _difficultyFromBackend(String? s) {
    switch (s) {
      case 'hard':
        return Difficulty.hard;
      case 'medium':
        return Difficulty.medium;
      case 'easy':
      default:
        return Difficulty.easy;
    }
  }

  bool _isUnlocked(Difficulty base, Difficulty target) {
    if (base == Difficulty.hard) return true; // semua terbuka
    if (base == Difficulty.medium) {
      return target == Difficulty.easy || target == Difficulty.medium;
    }
    return target == Difficulty.easy; // base easy
  }

  Future<void> _showLockedDialog(BuildContext context, Difficulty d) async {
    final name = switch (d) {
      Difficulty.easy => 'Mudah',
      Difficulty.medium => 'Sedang',
      Difficulty.hard => 'Sulit',
    };
    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Level Terkunci'),
        content: Text('Level "$name" belum terbuka. Selesaikan level sebelumnya dulu ya!'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK')),
        ],
      ),
    );
  }
}

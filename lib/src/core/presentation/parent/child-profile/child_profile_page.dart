import 'package:calisfun/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/widgets.dart';
import '../../../application/child_by_id_provider.dart';
import '../../../domain/domain.dart';

class ChildProfilePage extends ConsumerWidget {
  final String childId;

  const ChildProfilePage({super.key, required this.childId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncChild = ref.watch(childByIdProvider(childId));

    return Scaffold(
      backgroundColor: ColorApp.mainWhite,
      body: asyncChild.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(
          child: Padding(
            padding: EdgeInsets.all(SizeApp.w16),
            child: Text(
              'Gagal memuat profil anak.\n$err',
              textAlign: TextAlign.center,
              style: TypographyApp.bodyNormalMedium.copyWith(color: Colors.red),
            ),
          ),
        ),
        data: (child) {
          final readingProgress = child.progress.readingIds.length;
          final writingProgress = child.progress.writingIds.length;
          final difficultyProgress = child.countingDifficulty.toString();

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap.h80,
                const AppPrevButton(),
                Gap.h16,
                Text('Profile Anak', style: TypographyApp.headingLargeBoldPrimary),
                Gap.h16,
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRqUaGFKWrrv_RskYoykH2ONRynGRAAG6F0A&s',
                        ),
                      ),
                      Gap.h12,
                      Text(child.name, style: TypographyApp.headingLargeBold),
                      Gap.h16,
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Level ${child.level}', style: TypographyApp.labelSmallBold),
                        Gap.w4,
                        Text('(total xp ${child.xp})', style: TypographyApp.labelSmallMedium),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${child.streak} hari', style: TypographyApp.labelSmallBold),
                        Gap.w4,
                        Image.asset(
                          'assets/images/streak_img.png',
                          width: SizeApp.w24,
                          height: SizeApp.h28,
                        ),
                      ],
                    ),
                  ],
                ),
                Gap.h8,
                LinearProgressIndicator(
                  minHeight: SizeApp.h16,
                  borderRadius: BorderRadius.circular(100.r),
                  value: _overallProgress(child),
                  valueColor: AlwaysStoppedAnimation<Color>(ColorApp.primary),
                  backgroundColor: ColorApp.greyInactive,
                ),
                Gap.h8,
                Text('xp ${child.xp % 100}/100', style: TypographyApp.labelSmallBold),
                Gap.h16,
                Text(
                  'Progresmu',
                  style: TypographyApp.headingSmallBold.copyWith(color: ColorApp.primary),
                ),
                Gap.h16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildProgressItem(
                      color: ColorApp.sage,
                      image: 'assets/images/read_img.png',
                      title: 'Belajar',
                      subtitle: 'Membaca',
                      progress: '$readingProgress/10 soal',
                    ),
                    _buildProgressItem(
                      color: ColorApp.primary,
                      image: 'assets/images/write_img.png',
                      title: 'Belajar',
                      subtitle: 'Menulis',
                      progress: '$writingProgress/30 soal',
                    ),
                    _buildProgressItem(
                      color: ColorApp.secondary,
                      image: 'assets/images/count_img.png',
                      title: 'Belajar',
                      subtitle: 'Berhitung',
                      progress: difficultyProgress,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  double _overallProgress(Child c) {
    const xpPerLevel = 100;
    final currentLevelXp = c.xp % xpPerLevel;
    return currentLevelXp / xpPerLevel;
  }

  Widget _buildProgressItem({
    required Color color,
    required String image,
    required String title,
    required String subtitle,
    required String progress,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: SizeApp.w64,
          height: SizeApp.w64,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(100.r)),
          child: Center(
            child: Image.asset(image, width: SizeApp.w48, height: SizeApp.h48, fit: BoxFit.cover),
          ),
        ),
        Gap.h8,
        Text(title, style: TypographyApp.bodyNormalMedium),
        Text(subtitle, style: TypographyApp.bodyNormalMedium),
        Text(progress, style: TypographyApp.bodyNormalBold),
      ],
    );
  }
}

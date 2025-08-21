import 'package:calisfun/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../widgets/widgets.dart';

import '../../../domain/domain.dart';
import 'child_profile_controller.dart';

class ChildProfilePage extends ConsumerStatefulWidget {
  final Child child;

  const ChildProfilePage({super.key, required this.child});

  @override
  ConsumerState<ChildProfilePage> createState() => _ChildProfilePageState();
}

class _ChildProfilePageState extends ConsumerState<ChildProfilePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(childProfileControllerProvider.notifier).resetState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(childProfileControllerProvider);
    final controller = ref.read(childProfileControllerProvider.notifier);

    if (state.deleteSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profil ${widget.child.name} berhasil dihapus'),
            backgroundColor: Colors.green,
          ),
        );
      });
    }

    final readingProgress = widget.child.progress.readingIds.length;
    final writingProgress = widget.child.progress.writingIds.length;

    return Scaffold(
      backgroundColor: ColorApp.mainWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap.h80,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppPrevButton(),
                Container(
                  width: SizeApp.w48,
                  height: SizeApp.h48,
                  decoration: BoxDecoration(
                    color: ColorApp.secondary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/edit_ic.svg',
                      width: SizeApp.w24,
                      height: SizeApp.h24,
                      colorFilter: const ColorFilter.mode(
                        ColorApp.mainWhite,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap.h16,
            Text('Profile Anak', style: TypographyApp.headingLargeBoldPrimary),
            Gap.h16,
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://example.com/avatars/${widget.child.avatarImg}',
                    ),
                  ),
                  Gap.h12,
                  Text(widget.child.name, style: TypographyApp.headingLargeBold),
                  Gap.h16,
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Level ${widget.child.level}', style: TypographyApp.labelSmallBold),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${widget.child.streak} hari', style: TypographyApp.labelSmallBold),
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
              value: _calculateOverallProgress(widget.child),
              valueColor: AlwaysStoppedAnimation<Color>(ColorApp.primary),
              backgroundColor: ColorApp.greyInactive,
            ),
            Gap.h8,
            Text('xp ${widget.child.xp}', style: TypographyApp.labelSmallBold),
            Gap.h16,
            Text(
              'Progresmu',
              style: TypographyApp.headingSmallBold.copyWith(
                color: ColorApp.primary,
              ),
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
                  progress: '0/30 soal',
                ),
              ],
            ),
            Gap.h56,
            state.loading
                ? const Center(child: CircularProgressIndicator())
                : AppButton(
              backgroundColor: ColorApp.error,
              text: 'Hapus',
              onPressed: () => _showDeleteConfirmationDialog(context, controller),
            ),

            if (state.error != null) ...[
              Gap.h16,
              Text(
                state.error!,
                style: TypographyApp.bodyNormalMedium.copyWith(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              Gap.h8,
              AppButton(
                text: 'Coba Lagi',
                onPressed: () => controller.clearError(),
                backgroundColor: ColorApp.greyInactive,
              ),
            ],
          ],
        ),
      ),
    );
  }

  double _calculateOverallProgress(Child child) {
    final totalActivities = 40;
    final completedActivities = child.progress.readingIds.length + child.progress.writingIds.length;
    return completedActivities / totalActivities;
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
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Center(
            child: Image.asset(
              image,
              width: SizeApp.w48,
              height: SizeApp.h48,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Gap.h8,
        Text(title, style: TypographyApp.bodyNormalMedium),
        Text(subtitle, style: TypographyApp.bodyNormalMedium),
        Text(progress, style: TypographyApp.bodyNormalBold),
      ],
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context,
      ChildProfileController controller,
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Profil Anak'),
          content: Text(
            'Apakah Anda yakin ingin menghapus profil ${widget.child.name}? Tindakan ini tidak dapat dibatalkan.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.deleteChildProfile(widget.child.id);
              },
              child: const Text(
                'Hapus',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
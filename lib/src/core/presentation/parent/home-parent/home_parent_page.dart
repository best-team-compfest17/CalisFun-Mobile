import 'package:calisfun/src/core/presentation/parent/home-parent/home_parent_controller.dart';
import 'package:calisfun/src/core/presentation/parent/home-parent/home_parent_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/constants.dart';
import '../../../../routes/routes.dart';
import '../../../../widgets/widgets.dart';
import '../../../core.dart';

class HomeParentPage extends ConsumerWidget {
  const HomeParentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeParentControllerProvider);
    final controller = ref.read(homeParentControllerProvider.notifier);

    return Scaffold(
      backgroundColor: ColorApp.mainWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
        child: state.loading
            ? const Center(child: CircularProgressIndicator())
            : state.error != null
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error: ${state.error}',
                style: TypographyApp.bodyNormalMedium,
                textAlign: TextAlign.center,
              ),
              Gap.h16,
              AppButton(
                text: 'Coba Lagi',
                onPressed: () => controller.load(),
              )
            ],
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap.h80,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Halo, ${state.user?.username ?? 'User'}',
                  style: TypographyApp.headingLargeBoldPrimary,
                ),
                InkWell(
                  onTap: () => context.pushNamed(Routes.parentProfile.name),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      // state.user?.picture ??
                          'https://picsum.photos/200',
                    ),
                  ),
                ),
              ],
            ),
            Gap.h16,
            Text(
              'Aktivitas Anak',
              style: TypographyApp.headingLargeBoldPrimary,
            ),
            Gap.h16,
            _buildChildrenList(state, context),
            if (state.children.isEmpty) _buildEmptyState(),
            Gap.h24,
            AppButton(text: 'Tambah', onPressed: () => context.pushNamed(Routes.childProfileAdd.name))
          ],
        ),
      ),
    );
  }

  Widget _buildChildrenList(HomeParentState state, BuildContext context) {
    if (state.children.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: state.children.map((child) {
        return Padding(
          padding: EdgeInsets.only(bottom: SizeApp.h16),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChildProfilePage(childId: child.id),
                ),
              );
            },
            child: AppContainer(
              height: SizeApp.h80,
              childLeft: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(child.name, style: TypographyApp.headingSmallBold),
                  Gap.w8,
                  Text('Level ${child.level}', style: TypographyApp.headingSmallMedium),
                ],
              ),
              childRight: Container(
                width: SizeApp.customWidth(46),
                height: SizeApp.customHeight(46),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/arrow_next_ic.svg',
                    width: SizeApp.w24,
                    height: SizeApp.h24,
                    colorFilter: const ColorFilter.mode(
                      ColorApp.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              showBorder: true,
              showShadow: true,
              backgroundColor: ColorApp.mainWhite,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        Gap.h32,
        Image.asset(
          'assets/images/parent_empty_img.png',
          width: SizeApp.customWidth(300),
          height: SizeApp.customHeight(200),
        ),
        Gap.h16,
        Text(
          'Belum ada akun anak? Daftarkan sekarang biar bisa mulai.',
          style: TypographyApp.bodyNormalMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
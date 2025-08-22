import 'package:calisfun/src/constants/constants.dart';
import 'package:calisfun/src/widgets/app_button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/routes.dart';
import '../../../application/selected_child_provider.dart';
import 'select_child_controller.dart';

class SelectChildPage extends ConsumerWidget {
  const SelectChildPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(selectChildControllerProvider);
    final controller = ref.read(selectChildControllerProvider.notifier);

    return Scaffold(
      backgroundColor: ColorApp.darkBlue,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap.h40,
                  Text('Halo, Anak',
                      style: TypographyApp.headingLargeBold
                          .copyWith(color: ColorApp.mainWhite)),
                  Text('Siap untuk belajar?',
                      style: TypographyApp.headingLargeBold
                          .copyWith(color: ColorApp.greyInactive)),
                  Gap.h16,
                  Text('Siap memulai? Pilih namanya dulu, yuk!',
                      style: TypographyApp.bodyNormalRegular
                          .copyWith(color: ColorApp.greyInactive)),
                  Gap.h16,
                  if (state.loading) ...[
                    Gap.h24,
                    const Center(child: CircularProgressIndicator()),
                    Gap.h24,
                  ] else if (state.children.isEmpty) ...[

                    Gap.h80,
                    Center(child: Image.asset('assets/images/parent_empty_img.png', width: SizeApp.customWidth(300), height: SizeApp.customHeight(200),)),
                    Gap.h16,
                    Text(
                      'Belum ada akun anak? Daftarkan sekarang biar bisa mulai.',
                      style: TypographyApp.bodyNormalMedium.copyWith(color: ColorApp.mainWhite),
                      textAlign: TextAlign.center,
                    ),
                    Gap.h16,
                    AppButton(text: 'Ke halaman orang tua', onPressed: ()=> context.pushNamed(Routes.homeParent.name))
                  ] else ...[
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.children.length,
                      separatorBuilder: (_, __) => Gap.h12,
                      itemBuilder: (context, index) {
                        final child = state.children[index];
                        final isSelected = state.selectedChildId == child.id;
                        return InkWell(
                          onTap: () {
                            final child = state.children[index];
                            ref.read(selectedChildIdProvider.notifier).state = child.id;
                            context.goNamed(Routes.botnavbar.name);
                          },
                          borderRadius: BorderRadius.circular(10.r),
                          child: Container(
                            height: SizeApp.h52,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? ColorApp.mainWhite.withValues(alpha: 0.08)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: isSelected
                                    ? ColorApp.mainWhite
                                    : ColorApp.mainWhite,
                                width: 1.w,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Row(
                              children: [
                                Gap.w12,
                                Expanded(
                                  child: Text(
                                    child.name,
                                    style: TypographyApp.bodyNormalRegular
                                        .copyWith(color: ColorApp.mainWhite),
                                  ),
                                ),
                                if (isSelected)
                                  Icon(Icons.check,
                                      color: ColorApp.mainWhite, size: 20.r),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Gap.h24,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


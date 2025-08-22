import 'package:calisfun/src/routes/routes.dart';
import 'package:calisfun/src/widgets/app_container/app_container.dart';
import 'package:flutter/material.dart';
import 'package:calisfun/src/constants/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/child_by_id_provider.dart';
import '../../../application/selected_child_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedChildIdProvider);
    if (selectedId == null) {
      return const SizedBox.shrink();
    }

    final childAsync = ref.watch(childByIdProvider(selectedId));

    return childAsync.when(
      data: (child) {
        return Scaffold(
          backgroundColor: ColorApp.mainWhite,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap.h80,
                  Text('Halo, ${child.name}', style: TypographyApp.headingLargeBoldPrimary),
                  Gap.h16,
                  Text(
                    'Mau belajar apa?',
                    style: TypographyApp.headingLargeBoldPrimary,
                  ),
                  Gap.h16,
                  InkWell(
                    onTap: () {
                      final id = selectedId;
                      context.pushNamed(
                        Routes.learnSpell.name,
                        extra: id,
                      );
                    },
                    child: AppContainer(
                      backgroundColor: ColorApp.sage,
                      childLeft: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Belajar',
                            style: TypographyApp.headingLargeBold.copyWith(
                              color: ColorApp.mainWhite,
                            ),
                          ),
                          Text(
                            'Membaca',
                            style: TypographyApp.headingLargeBold.copyWith(
                              color: ColorApp.mainWhite,
                            ),
                          ),
                        ],
                      ),
                      childRight: Image.asset(
                        'assets/images/read_img.png',
                        width: SizeApp.customWidth(111),
                        height: SizeApp.customHeight(92),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Gap.h16,
                  InkWell(
                    onTap: () => context.pushNamed(Routes.category.name),
                    child: AppContainer(
                      backgroundColor: ColorApp.primary,
                      childLeft: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Belajar',
                            style: TypographyApp.headingLargeBold.copyWith(
                              color: ColorApp.mainWhite,
                            ),
                          ),
                          Text(
                            'Menulis',
                            style: TypographyApp.headingLargeBold.copyWith(
                              color: ColorApp.mainWhite,
                            ),
                          ),
                        ],
                      ),
                      childRight: Image.asset(
                        'assets/images/write_img.png',
                        width: SizeApp.customWidth(111),
                        height: SizeApp.customHeight(92),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Gap.h16,
                  InkWell(
                    onTap: () => context.pushNamed(
                      Routes.difficulty.name,
                      pathParameters: {'childId': selectedId},
                    ),
                    child: AppContainer(
                      backgroundColor: ColorApp.secondary,
                      childLeft: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Belajar',
                            style: TypographyApp.headingLargeBold.copyWith(
                              color: ColorApp.mainWhite,
                            ),
                          ),
                          Text(
                            'Menghitung',
                            style: TypographyApp.headingLargeBold.copyWith(
                              color: ColorApp.mainWhite,
                            ),
                          ),
                        ],
                      ),
                      childRight: Image.asset(
                        'assets/images/count_img.png',
                        width: SizeApp.customWidth(60),
                        height: SizeApp.customHeight(72),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, st) => Center(child: Text('Gagal memuat anak: $err')),
    );
  }
}

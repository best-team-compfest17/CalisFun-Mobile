import 'package:calisfun/src/constants/constants.dart';
import 'package:calisfun/src/core/presentation/onboarding/onboarding_controller.dart';
import 'package:calisfun/src/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OnBoardingPage extends ConsumerWidget {
  const OnBoardingPage({super.key});

  static final _pages = [
    {
      'asset': 'assets/images/img_onboarding1.png',
      'title': 'Belajar Calistung yang\nMenyenangkan',
      'subtitle':
          'Aktivitas singkat berbasis kurikulum untuk\nanak usia 6–9 tahun.',
    },
    {
      'asset': 'assets/images/img_onboarding2.png',
      'title': 'Satu Akun, Banyak Profil Anak',
      'subtitle':
          'Buat profil terpisah—level belajar\nmenyesuaikan kemampuan tiap anak.',
    },
    {
      'asset': 'assets/images/img_onboarding3.png',
      'title': 'Latihan Kapan Saja Dan Dimana Saja',
      'subtitle':
          'Menulis tangan, Mengeja, dan Berhitung siap digunakan dimana saja.',
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    return Scaffold(
<<<<<<< HEAD
      body: Center(
        child: AppButton(
          text: 'Lanjut Masuk',
          onPressed: () => context.pushNamed(Routes.signin.name),
=======
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: _pages.length,
                onPageChanged: (i) => controller.setPage(i),
                controller: controller.pageController,
                itemBuilder: (_, i) {
                  final data = _pages[i];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 32.h),
                        Expanded(
                          child: Center(
                            child: Image.asset(
                              data['asset']!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          data['title']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28.sp,
                            height: 1.25,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 22.h),
                        Text(
                          data['subtitle']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            height: 1.45,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 22.h),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                  height: 8.h,
                  width: i == state.currentPage ? 36.w : 16.w,
                  decoration: BoxDecoration(
                    color:
                        i == state.currentPage
                            ? ColorApp.primary
                            : Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 160.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: SizeApp.w48,
                    height: SizeApp.h48,
                    decoration: BoxDecoration(
                      color: ColorApp.primary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          controller.nextPage(_pages.length);
                          if (state.currentPage == _pages.length - 1) {
                            context.pushNamed(Routes.signin.name);
                          } else {
                            controller.setPage(state.currentPage + 1);
                          }
                        },
                        borderRadius: BorderRadius.circular(10.r),
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: ColorApp.mainWhite,
                            size: SizeApp.w24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
          ],
>>>>>>> 9df67450f8e0fd6ceac9bad9c8e896bcbe633ec9
        ),
      ),
    );
  }
}

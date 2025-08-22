import 'package:calisfun/src/constants/constants.dart';
import 'package:calisfun/src/core/presentation/child/home/home_page.dart';
import 'package:calisfun/src/core/presentation/child/leaderboard/leaderboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:go_router/go_router.dart';

import '../../../application/selected_child_provider.dart';
import '../../child/profile/profile_page.dart';
import 'botnavbar_controller.dart';
import '../../../../routes/routes.dart';

class BotNavBarPage extends ConsumerWidget {
  const BotNavBarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navState = ref.watch(botNavBarProvider);
    final navCtrl  = ref.read(botNavBarProvider.notifier);
    final selectedId = ref.watch(selectedChildIdProvider);
    final pages = <Widget>[
      const HomePage(),
      LeaderboardPage(childId: selectedId ?? ''),
      if (selectedId == null)
        Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Belum ada anak terpilih', style: TypographyApp.headingSmallBold),
                const SizedBox(height: 8),
                Text('Pilih anak dulu ya 🙂', style: TypographyApp.bodyNormalMedium),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.goNamed(Routes.selectChild.name),
                  child: const Text('Pilih Anak'),
                ),
              ],
            ),
          ),
        )
      else
        ProfilePage(childId: selectedId),
    ];

    return Scaffold(
      body: PageView(
        controller: navCtrl.pageController,
        onPageChanged: navCtrl.onPageChanged,
        children: pages,
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: GNav(
          gap: 8,
          color: ColorApp.greyInactive,
          activeColor: ColorApp.mainWhite,
          tabBackgroundColor: ColorApp.primary,
          padding: const EdgeInsets.all(12),
          selectedIndex: navState.index,
          onTabChange: navCtrl.onTabChange, // controller akan animasi ke page yg sesuai
          tabs: const [
            GButton(icon: Icons.home_rounded,        text: 'Beranda'),
            GButton(icon: Icons.leaderboard_rounded, text: 'Peringkat'),
            GButton(icon: Icons.person_rounded,      text: 'Profil'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(Routes.chatbot.name),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: ColorApp.primary,
        child: Icon(Icons.chat_bubble_rounded, color: ColorApp.mainWhite,),
        // child: SvgPicture.asset(
        //   'assets/icons/user_ic.svg',
        //   width: SizeApp.w24,
        //   height: SizeApp.h24,
        //   colorFilter: const ColorFilter.mode(ColorApp.mainWhite, BlendMode.srcIn),
        // ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

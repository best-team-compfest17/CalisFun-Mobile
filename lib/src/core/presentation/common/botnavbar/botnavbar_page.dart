import 'package:calisfun/src/constants/constants.dart';
import 'package:calisfun/src/core/presentation/child/home/home_page.dart';
import 'package:calisfun/src/core/presentation/child/leaderboard/leaderboard_page.dart';
import 'package:calisfun/src/core/presentation/parent/child-profile/child_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'botnavbar_controller.dart';

class BotNavBarPage extends ConsumerWidget {
  const BotNavBarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(botNavBarProvider);
    final controller = ref.read(botNavBarProvider.notifier);

    const pages = [
      HomePage(),
      LeaderboardPage(),
      // ChildProfilePage(c),
    ];

    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
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
          selectedIndex: state.index,
          onTabChange: controller.onTabChange,
          tabs: const [
            GButton(icon: Icons.home_rounded, text: 'Beranda'),
            GButton(icon: Icons.leaderboard_rounded, text: 'Peringkat'),
            GButton(icon: Icons.person_rounded, text: 'Profil'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        backgroundColor: ColorApp.primary,
        child: SvgPicture.asset(
          'assets/icons/user_ic.svg',
          width: SizeApp.w24,
          height: SizeApp.h24,
          colorFilter: const ColorFilter.mode(
            ColorApp.mainWhite,
            BlendMode.srcIn,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

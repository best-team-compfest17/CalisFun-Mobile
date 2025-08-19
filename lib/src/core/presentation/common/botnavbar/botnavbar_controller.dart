import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'botnavbar_state.dart';

final botNavBarProvider =
StateNotifierProvider<BotNavBarController, BotNavBarState>((ref) {
  final c = BotNavBarController();
  ref.onDispose(() => c.dispose()); // pastikan PageController dibersihkan
  return c;
});

class BotNavBarController extends StateNotifier<BotNavBarState> {
  BotNavBarController() : super(const BotNavBarState());

  final PageController pageController = PageController(initialPage: 0);

  void onTabChange(int i) {
    state = state.copyWith(index: i);
    pageController.animateToPage(
      i,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
    );
  }

  void onPageChanged(int i) {
    if (i != state.index) {
      state = state.copyWith(index: i);
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

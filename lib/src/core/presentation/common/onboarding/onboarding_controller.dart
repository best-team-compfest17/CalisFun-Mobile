import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'onboarding_state.dart';
import 'package:calisfun/src/shared/preferences/preferences.dart';

final onboardingControllerProvider =
StateNotifierProvider<OnboardingController, OnboardingState>(
      (ref) => OnboardingController(ref),
);

class OnboardingController extends StateNotifier<OnboardingState> {
  OnboardingController(this._ref) : super(const OnboardingState());
  final Ref _ref;

  final pageController = PageController();

  void setPage(int page) {
    state = state.copyWith(currentPage: page);
  }

  void nextPage(int maxPage) {
    if (state.currentPage < maxPage - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }


  Future<void> markSeen() async {
    await _ref.read(introPreferenceProvider).setHasSeenIntro(true);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

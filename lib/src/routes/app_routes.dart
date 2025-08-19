import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calisfun/src/core/core.dart';
import 'package:calisfun/src/routes/routes.dart';


enum Routes {
  splash,
  onboarding,
  signin,
  signup,
  home,
  category,
  difficulty,
  homeParent,
  childProfile,
  childProfileAdd,
  questionOpening,
  learnWrite,
  questionClosing,
  learnSpell,
  selectUser,
  selectChild,
  forgetPassword,
  createNewPassword,
  verificationOtp,
  leaderboard,
  botnavbar,
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/',
    routerNeglect: true,
    routes: [
      GoRoute(
        path: '/',
        name: Routes.splash.name,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/signin',
        name: Routes.signin.name,
        builder: (context, state) => const SigninPage(),
      ),
      GoRoute(
        path: '/signup',
        name: Routes.signup.name,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: '/home',
        name: Routes.home.name,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/category',
        name: Routes.category.name,
        builder: (context, state) => const CategoryPage(),
      ),
      GoRoute(
        path: '/difficulty',
        name: Routes.difficulty.name,
        builder: (context, state) => const DifficultyPage(),
      ),
      GoRoute(
        path: '/home-parent',
        name: Routes.homeParent.name,
        builder: (context, state) => const HomeParentPage(),
      ),
      GoRoute(
        path: '/child-profile',
        name: Routes.childProfile.name,
        builder: (context, state) => const ChildProfilePage(),
      ),
      GoRoute(
        path: '/child-profile-add',
        name: Routes.childProfileAdd.name,
        builder: (context, state) => const ChildProfileAddPage(),
      ),
      GoRoute(
        path: '/question-opening',
        name: Routes.questionOpening.name,
        builder: (context, state) => const QuestionOpeningPage(),
      ),
      GoRoute(
        path: '/learn-write',
        name: Routes.learnWrite.name,
        builder: (context, state) => const LearnWritePage(),
      ),
      GoRoute(
        path: '/question-closing',
        name: Routes.questionClosing.name,
        builder: (context, state) => const QuestionClosingPage(),
      ),
      GoRoute(
        path: '/learn-spell',
        name: Routes.learnSpell.name,
        builder: (context, state) => const LearnSpellPage(),
      ),
      GoRoute(
        path: '/select-user',
        name: Routes.selectUser.name,
        builder: (context, state) => const SelectUserPage(),
      ),
      GoRoute(
        path: '/select-child',
        name: Routes.selectChild.name,
        builder: (context, state) => const SelectChildPage(),
      ),
      GoRoute(
        path: '/forget-password',
        name: Routes.forgetPassword.name,
        builder: (context, state) => const ForgetPasswordPage(),
      ),
      GoRoute(
        path: '/onboarding',
        name: Routes.onboarding.name,
        builder: (context, state) => const OnBoardingPage(),
      ),
      GoRoute(
        path: '/verification-otp',
        name: Routes.verificationOtp.name,
        builder: (context, state) => const VerificationOtpPage(),
      ),
      GoRoute(
        path: '/create-new-password',
        name: Routes.createNewPassword.name,
        builder: (context, state) => const CreateNewPasswordPage(),
      ),
      GoRoute(
        path: '/leaderboard',
        name: Routes.leaderboard.name,
        builder: (context, state) => const LeaderboardPage(),
      ),
      GoRoute(
        path: '/botnavbar',
        name: Routes.botnavbar.name,
        builder: (context, state) => const BotNavBarPage(),
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(error: state.error),
  );
});

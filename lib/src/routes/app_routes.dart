import 'package:calisfun/src/core/presentation/child/chatbot/chatbot_page.dart';
import 'package:calisfun/src/core/presentation/child/learn_counting/learn_counting_page.dart';
import 'package:calisfun/src/core/presentation/parent/parent-profile/parent_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calisfun/src/core/core.dart';
import 'package:calisfun/src/routes/routes.dart';

import '../constants/constants.dart';

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
  parentProfile,
  chatbot,
  learnCounting,
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
        name: Routes.difficulty.name,
        path: '/difficulty/:childId',
        builder: (_, st) => DifficultyPage(
          // childId: st.pathParameters['childId']!,
        ),
      ),
      GoRoute(
        path: '/home-parent',
        name: Routes.homeParent.name,
        builder: (context, state) => const HomeParentPage(),
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
        name: Routes.learnWrite.name,
        path: '/learn-write',
        pageBuilder: (context, state) {
          // extra dikirim dari CategoryPage
          final extra = state.extra! as ({String childId, WritingCategory category});
          return MaterialPage(
            child: LearnWritePage(
              childId: extra.childId,
              category: extra.category,
            ),
          );
        },
      ),

      GoRoute(
        path: '/question-closing',
        name: Routes.questionClosing.name,
        builder: (context, state) => const QuestionClosingPage(),
      ),
      GoRoute(
        name: Routes.learnSpell.name,
        path: '/learn-spell',
        builder: (context, state) {
          final childId = state.extra as String;
          return LearnSpellPage(childId: childId);
        },
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
        builder: (context, state) {
          final childId = state.extra as String?;
          return LeaderboardPage(childId: childId ?? '');
        },
      ),
      GoRoute(
        path: '/botnavbar',
        name: Routes.botnavbar.name,
        builder: (context, state) => const BotNavBarPage(),
      ),
      GoRoute(
        path: '/parent-profile',
        name: Routes.parentProfile.name,
        builder: (context, state) => const ParentProfilePage(),
      ),
      GoRoute(
        path: '/chatbot',
        name: Routes.chatbot.name,
        builder: (context, state) => const ChatbotPage(),
      ),
      GoRoute(
        name: Routes.learnCounting.name,
        path: '/learn-counting',
        builder: (_, st) {
          final extra = st.extra as Map<String, dynamic>?;
          return LearnCountingPage(
            initialDifficulty: extra?['difficulty'] as Difficulty? ?? Difficulty.easy,
            childId: extra?['childId'] as String?,
          );
        },
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(error: state.error),
  );
});

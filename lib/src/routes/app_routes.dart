import 'package:calisfun/src/core/presentation/category/category_page.dart';
import 'package:calisfun/src/core/presentation/child-profile-add/child_profile_add_page.dart';
import 'package:calisfun/src/core/presentation/child-profile/child_profile_page.dart';
import 'package:calisfun/src/core/presentation/home-parent/home_parent_page.dart';
import 'package:calisfun/src/core/presentation/home/home_page.dart';
import 'package:calisfun/src/core/presentation/learn_write/learn_write_page.dart';
import 'package:calisfun/src/core/presentation/question_closing/question_closing_page.dart';
import 'package:calisfun/src/core/presentation/question_opening/question_opening_page.dart';
import 'package:calisfun/src/core/presentation/signin/signin_page.dart';
import 'package:calisfun/src/core/presentation/signup/signup_page.dart';
import 'package:calisfun/src/core/presentation/splash/splash_page.dart';
import 'package:calisfun/src/routes/error_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/presentation/difficulty/difficulty_page.dart';
import '../core/presentation/learn_spell/learn_spell_page.dart';

enum Routes {
  splash,
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
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/learn-spell',
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
    ],
    errorBuilder: (context, state) => ErrorPage(
      error: state.error,
    ),
  );
});

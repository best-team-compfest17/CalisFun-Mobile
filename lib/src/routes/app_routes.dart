import 'package:calisfun/src/core/presentation/category/category_page.dart';
import 'package:calisfun/src/core/presentation/child-profile-add/child_profile_add_page.dart';
import 'package:calisfun/src/core/presentation/home-parent/home_parent_page.dart';
import 'package:calisfun/src/core/presentation/home/home_page.dart';
import 'package:calisfun/src/core/presentation/signin/signin_page.dart';
import 'package:calisfun/src/core/presentation/signup/signup_page.dart';
import 'package:calisfun/src/core/presentation/splash/splash_page.dart';
import 'package:calisfun/src/routes/error_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/presentation/difficulty/difficulty_page.dart';

enum Routes {
  splash,
  signin,
  signup,
  home,
  category,
  difficulty,
  homeParent,
  childProfileAdd
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/child-profile-add',
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
        path: '/child-profile-add',
        name: Routes.childProfileAdd.name,
        builder: (context, state) => const ChildProfileAddPage(),
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(
      error: state.error,
    ),
  );
});

import 'package:calisfun/src/core/presentation/signin/signin_page.dart';
import 'package:calisfun/src/core/presentation/signup/signup_page.dart';
import 'package:calisfun/src/core/presentation/splash/splash_page.dart';
import 'package:calisfun/src/routes/error_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Routes {
  splash,
  signin,
  signup
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/signup',
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
    ],
    errorBuilder: (context, state) => ErrorPage(
      error: state.error,
    ),
  );
});

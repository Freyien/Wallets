import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:montebit/features/login/ui/login_page.dart';
import 'package:montebit/features/signup/ui/signup_page.dart';

class AppRouter {
  AppRouter();

  final navigatorKey = GlobalKey<NavigatorState>();

  GoRouter get router {
    return GoRouter(
      initialLocation: SignupPage.route,
      navigatorKey: navigatorKey,
      routes: [
        GoRoute(
          path: SignupPage.route,
          builder: (context, state) {
            return const SignupPage();
          },
        ),
        GoRoute(
          path: LoginPage.route,
          builder: (context, state) {
            return const LoginPage();
          },
        ),
      ],
    );
  }
}

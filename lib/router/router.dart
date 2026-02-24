import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:montebit/features/login/ui/login_page.dart';

class AppRouter {
  AppRouter();

  final navigatorKey = GlobalKey<NavigatorState>();

  GoRouter get router {
    return GoRouter(
      initialLocation: LoginPage.route,
      navigatorKey: navigatorKey,
      routes: [
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

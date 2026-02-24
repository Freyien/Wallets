import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:montebit/features/add_card/ui/add_card_page.dart';
import 'package:montebit/features/cards/ui/cards_page.dart';
import 'package:montebit/features/forgot_password/ui/forgot_password_page.dart';
import 'package:montebit/features/login/ui/login_page.dart';
import 'package:montebit/features/signup/ui/signup_page.dart';
import 'package:montebit/features/splash/models/initial_route_model.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  AppRouter(this.initialRoute);

  final InitialRouteModel initialRoute;

  late final GoRouter _router = _buildRouter();

  GoRouter get router => _router;

  GoRouter _buildRouter() {
    return GoRouter(
      initialLocation: initialRoute.route,
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
        GoRoute(
          path: CardsPage.route,
          builder: (context, state) {
            return const CardsPage();
          },
        ),
        GoRoute(
          path: AddCardPage.route,
          builder: (context, state) {
            return const AddCardPage();
          },
        ),
        GoRoute(
          path: ForgotPasswordPage.route,
          builder: (context, state) {
            return const ForgotPasswordPage();
          },
        ),
      ],
    );
  }
}

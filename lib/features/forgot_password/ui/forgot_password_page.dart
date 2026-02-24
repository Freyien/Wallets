import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:montebit/core/ui/widgets/error_full_screen.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  static const route = '/forgot-password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ErrorFullScreen(
          icon: Icons.build,
          title: 'Pantalla en construcción',
          message: 'Esta pantalla está en construcción.',
          textButton: 'Volver',
          onAction: () {
            context.pop();
          },
        ),
      ),
    );
  }
}

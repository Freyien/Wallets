import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:montebit/features/forgot_password/ui/forgot_password_page.dart';

class LoginForgotPasswordButton extends StatelessWidget {
  const LoginForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          context.push(ForgotPasswordPage.route);
        },
        child: const Text('¿Olvidaste tu contraseña?'),
      ),
    );
  }
}

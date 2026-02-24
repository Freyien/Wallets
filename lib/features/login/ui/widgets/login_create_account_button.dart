import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:montebit/core/ui/widgets/core_widgets.dart';
import 'package:montebit/features/signup/ui/signup_page.dart';

class LoginCreateAccountButton extends StatelessWidget {
  const LoginCreateAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      text: 'Crear cuenta',
      onPressed: () {
        context.push(SignupPage.route);
      },
    );
  }
}

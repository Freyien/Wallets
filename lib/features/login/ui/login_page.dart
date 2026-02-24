import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/core/ui/widgets/primary_button.dart';
import 'package:montebit/core/ui/widgets/vertical_space.dart';
import 'package:montebit/di/injection_modules.dart';
import 'package:montebit/features/login/ui/bloc/login_bloc.dart';
import 'package:montebit/features/login/ui/widgets/login_confirm_password_input.dart';
import 'package:montebit/features/login/ui/widgets/login_email_input.dart';
import 'package:montebit/features/login/ui/widgets/login_nickname_input.dart';
import 'package:montebit/features/login/ui/widgets/login_password_input.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static String route = '/signup';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginBloc>()..add(GetLoginEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Registro')),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Title
                const Text('Completa el formulario para registrarte.'),
                VerticalSpace.large(),

                // Nickname
                const LoginNicknameInput(),
                VerticalSpace.medium(),

                // Email
                const LoginEmailInput(),
                VerticalSpace.medium(),

                // Password
                const LoginPasswordInput(),
                VerticalSpace.medium(),

                // Confirm Password
                const LoginConfirmPasswordInput(),
                VerticalSpace.xxlarge(),

                // Button
                PrimaryButton(text: 'Registrar', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

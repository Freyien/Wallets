import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/core/ui/widgets/hide_keyboard.dart';
import 'package:montebit/core/ui/widgets/vertical_space.dart';
import 'package:montebit/di/injection_modules.dart';
import 'package:montebit/features/signup/ui/bloc/signup_bloc.dart';
import 'package:montebit/features/signup/ui/widgets/signup_button.dart';
import 'package:montebit/features/signup/ui/widgets/signup_confirm_password_input.dart';
import 'package:montebit/features/signup/ui/widgets/signup_email_input.dart';
import 'package:montebit/features/signup/ui/widgets/signup_fullname_input.dart';
import 'package:montebit/features/signup/ui/widgets/signup_listener.dart';
import 'package:montebit/features/signup/ui/widgets/signup_password_input.dart';
import 'package:montebit/features/signup/ui/widgets/signup_password_requirements.dart';
import 'package:montebit/features/signup/ui/widgets/signup_phone_input.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  static String route = '/signup';

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => sl<SignupBloc>(),
      child: SignupListener(
        child: Scaffold(
          appBar: AppBar(title: const Text('Registro')),
          body: HideKeyboard(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // Title
                      const Text('Completa el formulario para registrarte.'),
                      VerticalSpace.large(),

                      // Nickname
                      const SignupFullNameInput(),
                      VerticalSpace.large(),

                      // Email
                      const SignupEmailInput(),
                      VerticalSpace.large(),

                      // Phone
                      const SignupPhoneInput(),
                      VerticalSpace.large(),

                      // Password
                      const SignupPasswordInput(),
                      VerticalSpace.medium(),

                      // Password Requirements
                      const SignupPasswordRequirements(),
                      VerticalSpace.large(),

                      // Confirm Password
                      const SignupConfirmPasswordInput(),
                      VerticalSpace.xxlarge(),

                      // Button
                      SignupButton(formKey: formKey),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

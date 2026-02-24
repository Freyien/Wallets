import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/core/ui/widgets/core_widgets.dart';
import 'package:montebit/di/injection_modules.dart';
import 'package:montebit/features/login/ui/bloc/login_bloc.dart';
import 'package:montebit/features/login/ui/widgets/login_button.dart';
import 'package:montebit/features/login/ui/widgets/login_create_account_button.dart';
import 'package:montebit/features/login/ui/widgets/login_email_input.dart';
import 'package:montebit/features/login/ui/widgets/login_forgot_password_button.dart';
import 'package:montebit/features/login/ui/widgets/login_listener.dart';
import 'package:montebit/features/login/ui/widgets/login_password_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static String route = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: SafeArea(
          child: LoginListener(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Title
                  const Text('Completa el formulario para iniciar sesión.'),
                  VerticalSpace.large(),

                  // Email
                  const LoginEmailInput(),
                  VerticalSpace.xlarge(),

                  // Password
                  const LoginPasswordInput(),

                  // Forgot password
                  const LoginForgotPasswordButton(),
                  VerticalSpace.large(),

                  // Login button
                  LoginButton(formKey: _formKey),
                  VerticalSpace.medium(),

                  // Create account button
                  const LoginCreateAccountButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

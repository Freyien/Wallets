import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/core/ui/widgets/primary_button.dart';
import 'package:montebit/core/ui/widgets/vertical_space.dart';
import 'package:montebit/di/injection_modules.dart';
import 'package:montebit/features/login/ui/bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static String route = '/login';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginBloc>()..add(GetLoginEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text('Registro')),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text('Completa el formulario para registrarte.'),
                VerticalSpace.large(),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nickname'),
                ),
                VerticalSpace.medium(),
                // Email input
                TextFormField(decoration: InputDecoration(labelText: 'Email')),
                VerticalSpace.medium(),
                // Password input
                TextFormField(
                  decoration: InputDecoration(labelText: 'Contraseña'),
                ),
                VerticalSpace.medium(),
                // Confirm password input
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirmar contraseña',
                  ),
                ),

                VerticalSpace.xxlarge(),
                PrimaryButton(text: 'Registrar', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

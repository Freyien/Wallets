import 'package:flutter/material.dart';
import 'package:montebit/features/login/utils/login_validators.dart';

class LoginPasswordInput extends StatelessWidget {
  const LoginPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: 'Contraseña',
        border: OutlineInputBorder(),
      ),
      validator: LoginValidators.validatePassword,
    );
  }
}

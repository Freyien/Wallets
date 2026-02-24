import 'package:flutter/material.dart';
import 'package:montebit/features/login/utils/login_validators.dart';

class LoginConfirmPasswordInput extends StatelessWidget {
  const LoginConfirmPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        labelText: 'Confirmar contraseña',
        border: OutlineInputBorder(),
      ),
      validator: (value) => LoginValidators.validateConfirmPassword(
        '',
        value,
      ), // Validate via Bloc later
    );
  }
}

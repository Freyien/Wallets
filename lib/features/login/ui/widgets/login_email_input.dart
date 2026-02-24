import 'package:flutter/material.dart';
import 'package:montebit/features/login/utils/login_validators.dart';

class LoginEmailInput extends StatelessWidget {
  const LoginEmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
        hintText: 'ejemplo@correo.com',
      ),
      validator: LoginValidators.validateEmail,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:montebit/features/login/utils/login_validators.dart';

class LoginNicknameInput extends StatelessWidget {
  const LoginNicknameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: 'Nickname',
        border: OutlineInputBorder(),
        hintText: 'Ej. JuanPerez',
      ),
      validator: LoginValidators.validateFullname,
    );
  }
}

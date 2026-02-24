import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/features/login/ui/bloc/login_bloc.dart';
import 'package:montebit/features/login/utils/login_validators.dart';

class LoginPasswordInput extends StatelessWidget {
  const LoginPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(labelText: 'Contraseña'),
      onChanged: (value) =>
          context.read<LoginBloc>().add(ChangePasswordEvent(value)),
      validator: LoginValidators.validatePassword,
    );
  }
}

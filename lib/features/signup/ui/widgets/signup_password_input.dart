import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/features/signup/ui/bloc/signup_bloc.dart';
import 'package:montebit/features/signup/utils/signup_validators.dart';

class SignupPasswordInput extends StatelessWidget {
  const SignupPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      textInputAction: TextInputAction.next,
      onChanged: (value) =>
          context.read<SignupBloc>().add(ChangePasswordEvent(value)),
      decoration: const InputDecoration(labelText: 'Contraseña'),
      validator: SignupValidators.validatePassword,
    );
  }
}

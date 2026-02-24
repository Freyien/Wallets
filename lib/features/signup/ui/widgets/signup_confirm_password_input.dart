import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/features/signup/ui/bloc/signup_bloc.dart';
import 'package:montebit/features/signup/utils/signup_validators.dart';

class SignupConfirmPasswordInput extends StatelessWidget {
  const SignupConfirmPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: (value) =>
          context.read<SignupBloc>().add(ChangeConfirmPasswordEvent(value)),
      decoration: const InputDecoration(labelText: 'Confirmar contraseña'),
      validator: (value) => SignupValidators.validateConfirmPassword(
        context.read<SignupBloc>().state.signup.password,
        value,
      ),
    );
  }
}

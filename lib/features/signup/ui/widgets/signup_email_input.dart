import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/features/signup/ui/bloc/signup_bloc.dart';
import 'package:montebit/features/signup/utils/signup_validators.dart';

class SignupEmailInput extends StatelessWidget {
  const SignupEmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (value) =>
          context.read<SignupBloc>().add(ChangeEmailEvent(value)),
      decoration: const InputDecoration(
        labelText: 'Email',
        hintText: 'ejemplo@correo.com',
      ),
      validator: SignupValidators.validateEmail,
    );
  }
}

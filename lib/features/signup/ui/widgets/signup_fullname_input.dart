import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/features/signup/ui/bloc/signup_bloc.dart';
import 'package:montebit/features/signup/utils/signup_validators.dart';

class SignupFullNameInput extends StatelessWidget {
  const SignupFullNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (value) =>
          context.read<SignupBloc>().add(ChangeNickNameEvent(value)),
      decoration: const InputDecoration(
        labelText: 'Nombre completo',
        hintText: 'Ej. Juan Perez',
      ),
      validator: SignupValidators.validateFullname,
    );
  }
}

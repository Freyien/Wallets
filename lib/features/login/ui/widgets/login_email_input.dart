import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/features/login/ui/bloc/login_bloc.dart';
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
        hintText: 'ejemplo@correo.com',
      ),
      onChanged: (value) =>
          context.read<LoginBloc>().add(ChangeEmailEvent(value)),
      validator: LoginValidators.validateEmail,
    );
  }
}

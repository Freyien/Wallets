import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/features/signup/ui/bloc/signup_bloc.dart';
import 'package:montebit/features/signup/utils/signup_validators.dart';

class SignupPasswordInput extends StatefulWidget {
  const SignupPasswordInput({super.key});

  @override
  State<SignupPasswordInput> createState() => _SignupPasswordInputState();
}

class _SignupPasswordInputState extends State<SignupPasswordInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      textInputAction: TextInputAction.next,
      onChanged: (value) =>
          context.read<SignupBloc>().add(ChangePasswordEvent(value)),
      decoration: InputDecoration(
        labelText: 'Contraseña',
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      validator: SignupValidators.validatePassword,
    );
  }
}

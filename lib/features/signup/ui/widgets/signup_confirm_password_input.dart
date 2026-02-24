import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/features/signup/ui/bloc/signup_bloc.dart';
import 'package:montebit/features/signup/utils/signup_validators.dart';

class SignupConfirmPasswordInput extends StatefulWidget {
  const SignupConfirmPasswordInput({super.key});

  @override
  State<SignupConfirmPasswordInput> createState() =>
      _SignupConfirmPasswordInputState();
}

class _SignupConfirmPasswordInputState
    extends State<SignupConfirmPasswordInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      textInputAction: TextInputAction.done,
      onChanged: (value) =>
          context.read<SignupBloc>().add(ChangeConfirmPasswordEvent(value)),
      decoration: InputDecoration(
        labelText: 'Confirmar contraseña',
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
      validator: (value) => SignupValidators.validateConfirmPassword(
        context.read<SignupBloc>().state.signup.password,
        value,
      ),
    );
  }
}

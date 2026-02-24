import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/features/signup/ui/bloc/signup_bloc.dart';
import 'package:montebit/features/signup/utils/signup_validators.dart';

class SignupPhoneInput extends StatelessWidget {
  const SignupPhoneInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      onChanged: (value) =>
          context.read<SignupBloc>().add(ChangePhoneEvent(value)),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      decoration: const InputDecoration(
        labelText: 'Teléfono',
        hintText: '1234567890',
        prefixText: '+52 ',
      ),
      validator: SignupValidators.validatePhone,
    );
  }
}

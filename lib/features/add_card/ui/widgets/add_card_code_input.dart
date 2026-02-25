import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/features/add_card/ui/bloc/add_card_bloc.dart';
import 'package:montebit/features/add_card/utils/add_card_validators.dart';

class AddCardCodeInput extends StatelessWidget {
  const AddCardCodeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      obscureText: true,
      decoration: const InputDecoration(labelText: 'CVV', hintText: '***'),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
      ],
      textInputAction: TextInputAction.done,
      onChanged: (value) =>
          context.read<AddCardBloc>().add(ChangeCodeEvent(value)),
      validator: (value) => AddCardValidators.validateCode(value),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/features/add_card/ui/bloc/add_card_bloc.dart';
import 'package:montebit/features/add_card/utils/add_card_validators.dart';

class AddCardValidityInput extends StatelessWidget {
  const AddCardValidityInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.datetime,
      decoration: const InputDecoration(
        labelText: 'Fecha de expiración',
        hintText: 'MM/YY',
        prefixIcon: Icon(Icons.calendar_today),
      ),
      onChanged: (value) =>
          context.read<AddCardBloc>().add(ChangeValidityEvent(value)),
      validator: (value) => AddCardValidators.validateValidity(value),
    );
  }
}

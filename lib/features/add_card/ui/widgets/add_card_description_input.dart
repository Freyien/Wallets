import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/features/add_card/ui/bloc/add_card_bloc.dart';
import 'package:montebit/features/add_card/utils/add_card_validators.dart';

class AddCardDescriptionInput extends StatelessWidget {
  const AddCardDescriptionInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Alias de tarjeta',
        hintText: 'Ej. Tarjeta Personal',
        helperText: 'Mínimo 5 caracteres',
      ),
      maxLength: 20,
      onChanged: (value) =>
          context.read<AddCardBloc>().add(ChangeDescriptionEvent(value)),
      validator: (value) => AddCardValidators.validateDescription(value),
    );
  }
}

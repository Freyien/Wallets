import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/features/add_card/ui/bloc/add_card_bloc.dart';
import 'package:montebit/features/add_card/utils/add_card_validators.dart';

class AddCardHolderInput extends StatelessWidget {
  const AddCardHolderInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Nombre del titular',
        hintText: 'Ej. Juan Pérez',
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(40)],
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      onChanged: (value) =>
          context.read<AddCardBloc>().add(ChangeCardHolderEvent(value)),
      validator: (value) => AddCardValidators.validateCardHolder(value),
    );
  }
}

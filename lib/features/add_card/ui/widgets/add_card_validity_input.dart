import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/features/add_card/ui/bloc/add_card_bloc.dart';
import 'package:montebit/features/add_card/utils/add_card_validators.dart';
import 'package:montebit/features/add_card/utils/date_input_formatter.dart';

class AddCardValidityInput extends StatelessWidget {
  const AddCardValidityInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
        LengthLimitingTextInputFormatter(5),
        DateInputFormatter(),
      ],
      textInputAction: TextInputAction.next,
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

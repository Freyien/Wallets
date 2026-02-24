import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/core/domain/enums/saving_status.dart';
import 'package:montebit/core/ui/widgets/core_widgets.dart';
import 'package:montebit/features/add_card/ui/bloc/add_card_bloc.dart';

class AddCardSubmitButton extends StatelessWidget {
  const AddCardSubmitButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCardBloc, AddCardState>(
      buildWhen: (p, c) => p.savingStatus != c.savingStatus,
      builder: (context, state) {
        final isLoading = state.savingStatus == SavingStatus.loading;

        return PrimaryButton(
          text: 'Continuar',
          isLoading: isLoading,
          onPressed: () {
            if (formKey.currentState!.validate()) {
              context.read<AddCardBloc>().add(SaveCardEvent());
            }
          },
          isExpanded: false,
        );
      },
    );
  }
}

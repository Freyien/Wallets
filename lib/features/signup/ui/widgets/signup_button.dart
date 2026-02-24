import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/core/domain/enums/saving_status.dart';
import 'package:montebit/core/ui/widgets/core_widgets.dart';
import 'package:montebit/features/signup/ui/bloc/signup_bloc.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (p, c) => p.savingStatus != c.savingStatus,
      builder: (context, state) {
        final isLoading = state.savingStatus == SavingStatus.loading;

        return PrimaryButton(
          text: 'Registrar',
          isLoading: isLoading,
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              context.read<SignupBloc>().add(DoSignupEvent());
            }
          },
        );
      },
    );
  }
}

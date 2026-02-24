import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/core/domain/enums/fetching_status.dart';
import 'package:montebit/core/ui/widgets/core_widgets.dart';
import 'package:montebit/features/login/ui/bloc/login_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({required this.formKey, super.key});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (p, c) => p.fetchingStatus != c.fetchingStatus,
      builder: (context, state) {
        final isLoading = state.fetchingStatus == FetchingStatus.loading;

        return PrimaryButton(
          text: 'Iniciar sesión',
          isLoading: isLoading,
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              context.read<LoginBloc>().add(DoLoginEvent());
            }
          },
        );
      },
    );
  }
}

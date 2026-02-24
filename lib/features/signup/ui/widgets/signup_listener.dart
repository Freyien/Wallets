import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:montebit/core/domain/enums/saving_status.dart';
import 'package:montebit/features/cards/ui/cards_page.dart';
import 'package:montebit/features/signup/ui/bloc/signup_bloc.dart';

class SignupListener extends StatelessWidget {
  const SignupListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listenWhen: (p, c) => p.savingStatus != c.savingStatus,
      listener: (context, state) {
        if (state.savingStatus == SavingStatus.success) {
          context.go(CardsPage.route);
        }
      },
      child: child,
    );
  }
}

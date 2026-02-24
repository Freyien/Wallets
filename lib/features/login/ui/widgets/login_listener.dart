import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:montebit/core/domain/enums/fetching_status.dart';
import 'package:montebit/features/cards/ui/cards_page.dart';
import 'package:montebit/features/login/ui/bloc/login_bloc.dart';

class LoginListener extends StatelessWidget {
  const LoginListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (p, c) => p.fetchingStatus != c.fetchingStatus,
      listener: (context, state) {
        if (state.fetchingStatus == FetchingStatus.success) {
          return context.go(CardsPage.route);
        }

        if (state.fetchingStatus == FetchingStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Error al iniciar sesión. Verifica tus credenciales.',
              ),
            ),
          );

          return;
        }
      },
      child: child,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:montebit/core/domain/enums/fetching_status.dart';
import 'package:montebit/features/login/ui/login_page.dart';
import 'package:montebit/features/logout/ui/bloc/logout_bloc.dart';
import 'package:montebit/features/logout/ui/bloc/logout_state.dart';

class LogoutListener extends StatelessWidget {
  const LogoutListener({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutBloc, LogoutState>(
      listenWhen: (p, c) => p.logoutStatus != c.logoutStatus,
      listener: (context, state) {
        if (state.logoutStatus.isSuccess) {
          context.go(LoginPage.route);
        }
      },
      child: child,
    );
  }
}

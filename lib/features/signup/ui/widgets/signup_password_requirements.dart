import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/core/ui/widgets/vertical_space.dart';
import 'package:montebit/features/signup/ui/bloc/signup_bloc.dart';

class SignupPasswordRequirements extends StatelessWidget {
  const SignupPasswordRequirements({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (p, c) => p.signup.password != c.signup.password,
      builder: (context, state) {
        final password = state.signup.password;

        final hasMinLength = password.length >= 8;
        final hasUppercase = password.contains(RegExp(r'[A-Z]'));
        final hasLowercase = password.contains(RegExp(r'[a-z]'));
        final hasNumber = password.contains(RegExp(r'[0-9]'));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _RequirementItem(text: 'Mínimo 8 caracteres', isMet: hasMinLength),
            VerticalSpace.small(),
            _RequirementItem(text: 'Una mayúscula', isMet: hasUppercase),
            VerticalSpace.small(),
            _RequirementItem(text: 'Una minúscula', isMet: hasLowercase),
            VerticalSpace.small(),
            _RequirementItem(text: 'Un número', isMet: hasNumber),
          ],
        );
      },
    );
  }
}

class _RequirementItem extends StatelessWidget {
  const _RequirementItem({required this.text, required this.isMet});

  final String text;
  final bool isMet;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isMet ? Colors.green : Colors.grey,
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: isMet ? Colors.green : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

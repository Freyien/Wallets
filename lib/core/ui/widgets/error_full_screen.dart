import 'package:flutter/material.dart';
import 'package:montebit/core/ui/widgets/core_widgets.dart';

class ErrorFullScreen extends StatelessWidget {
  const ErrorFullScreen({
    required this.onAction,
    super.key,
    this.title,
    this.message,
    this.textButton,
    this.icon,
  });

  final void Function() onAction;
  final String? title;
  final String? message;
  final String? textButton;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon ?? Icons.credit_card, size: 150),
            VerticalSpace.large(),
            Column(
              children: [
                Text(
                  title ?? '¡Ha sucedido un error!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -.5,
                  ),
                ),
                Text(
                  message ?? 'Intenta de nuevo más tarde.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
            VerticalSpace.custom(40),

            PrimaryButton(
              text: textButton ?? 'Reintentar',
              onPressed: onAction,
            ),
            VerticalSpace.xxlarge(),
          ],
        ),
      ),
    );
  }
}

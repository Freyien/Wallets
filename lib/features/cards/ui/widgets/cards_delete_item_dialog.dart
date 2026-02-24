import 'package:flutter/material.dart';
import 'package:montebit/core/domain/entities/card_entity.dart';

class CardsDeleteItemDialog extends StatelessWidget {
  const CardsDeleteItemDialog({
    super.key,
    required this.card,
    required this.onConfirm,
  });

  final CardEntity card;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Eliminar Tarjeta'),
      content: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            const TextSpan(text: '¿Estás seguro de eliminar tu tarjeta '),
            TextSpan(
              text: card.description,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: ' con terminación '),
            TextSpan(
              text: card.last4Digits,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: '?'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}

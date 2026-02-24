import 'package:flutter/material.dart';
import 'package:montebit/core/ui/widgets/core_widgets.dart';

class AddCardCancelButton extends StatelessWidget {
  const AddCardCancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      text: 'Cancelar',
      onPressed: () => Navigator.pop(context),
      isExpanded: false,
    );
  }
}

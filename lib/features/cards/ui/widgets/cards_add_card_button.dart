import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:montebit/features/add_card/ui/add_card_page.dart';

class AddCardButton extends StatelessWidget {
  const AddCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        context.push(AddCardPage.route);
      },
      label: Text('Agregar tarjeta'),
      icon: Icon(Icons.add),
    );
  }
}

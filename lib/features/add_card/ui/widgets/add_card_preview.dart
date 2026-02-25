import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/features/add_card/ui/bloc/add_card_bloc.dart';
import 'package:montebit/features/cards/ui/widgets/card_item.dart';

class AddCardPreview extends StatelessWidget {
  const AddCardPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCardBloc, AddCardState>(
      buildWhen: (p, c) => p.addCard != c.addCard,
      builder: (context, state) {
        return CardItem(
          card: state.addCard,
          showDeleteButton: false,
        );
      },
    );
  }
}

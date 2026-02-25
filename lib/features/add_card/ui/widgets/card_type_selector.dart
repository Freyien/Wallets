import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/core/domain/entities/card_entity.dart';
import 'package:montebit/core/ui/widgets/core_widgets.dart';
import 'package:montebit/features/add_card/ui/bloc/add_card_bloc.dart';

class CardTypeSelector extends StatelessWidget {
  const CardTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCardBloc, AddCardState>(
      buildWhen: (p, c) => p.addCard.card != c.addCard.card,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Tipo de tarjeta', style: TextStyle(fontSize: 14)),
            VerticalSpace.xsmall(),

            SegmentedButton<CardType>(
              segments: [
                ButtonSegment(value: CardType.credit, label: Text('Crédito')),
                ButtonSegment(value: CardType.debit, label: Text('Débito')),
                ButtonSegment(value: CardType.points, label: Text('Puntos')),
              ],
              selected: {state.addCard.card},
              onSelectionChanged: (Set<CardType> newSelection) {
                context.read<AddCardBloc>().add(
                  ChangeCardTypeEvent(newSelection.first),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

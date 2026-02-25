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
      buildWhen: (p, c) =>
          p.addCard.cardType != c.addCard.cardType ||
          p.addCard.cardNumber != c.addCard.cardNumber,
      builder: (context, state) {
        final card = state.addCard;
        final processor = card.displayProcessorType;

        final showCreditOption = processor != ProcessorType.unknown;
        final showDebitOption = processor != ProcessorType.unknown;
        final showPointsOption = processor == ProcessorType.unknown;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Tipo de tarjeta', style: TextStyle(fontSize: 14)),
            VerticalSpace.xsmall(),

            SegmentedButton<CardType>(
              segments: [
                if (showCreditOption)
                  ButtonSegment(value: CardType.credit, label: Text('Crédito')),
                if (showDebitOption)
                  ButtonSegment(value: CardType.debit, label: Text('Débito')),
                if (showPointsOption)
                  ButtonSegment(value: CardType.points, label: Text('Puntos')),
              ],
              selected: {state.addCard.cardType},
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

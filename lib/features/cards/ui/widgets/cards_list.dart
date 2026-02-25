import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/core/domain/entities/card_entity.dart';
import 'package:montebit/core/ui/widgets/vertical_space.dart';
import 'package:montebit/features/cards/ui/bloc/cards_bloc.dart';
import 'package:montebit/features/cards/ui/widgets/card_item.dart';

class CardsList extends StatelessWidget {
  const CardsList({super.key, required this.cards});

  final List<CardEntity> cards;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<CardsBloc>().add(GetCardsEvent());
      },
      child: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final isLast = index == cards.length - 1;
          final card = cards[index];

          return Column(
            children: [
              CardItem(card: card),
              if (isLast)
                SafeArea(
                  top: false,
                  child: VerticalSpace.custom(100),
                ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return VerticalSpace.xxlarge();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/core/domain/entities/card_entity.dart';
import 'package:montebit/core/ui/widgets/vertical_space.dart';
import 'package:montebit/features/cards/ui/bloc/cards_bloc.dart';
import 'package:montebit/features/cards/ui/widgets/card_item.dart';
import 'package:montebit/features/cards/ui/widgets/cards_out_animation.dart';

class CardsList extends StatefulWidget {
  const CardsList({super.key, required this.cards});

  final List<CardEntity> cards;

  @override
  State<CardsList> createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<CardEntity> _cards;

  @override
  void initState() {
    super.initState();
    _cards = List.from(widget.cards);
  }

  @override
  void didUpdateWidget(CardsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.cards.length >= oldWidget.cards.length) {
      return;
    }

    final deletedCard = oldWidget.cards.firstWhere(
      (oldCard) => !widget.cards.any((c) => c.id == oldCard.id),
    );

    final index = _cards.indexWhere((c) => c.id == deletedCard.id);
    if (index == -1) return;

    final removedItem = _cards.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => CardsOutAnimation(
        card: removedItem,
        animation: animation,
      ),
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<CardsBloc>().add(GetCardsEvent());
      },
      child: AnimatedList(
        key: _listKey,
        padding: const EdgeInsets.all(16),
        initialItemCount: _cards.length,
        itemBuilder: (context, index, animation) {
          final isLast = index == _cards.length - 1;
          final card = _cards[index];

          return Column(
            children: [
              CardItem(card: card),
              if (isLast)
                SafeArea(
                  top: false,
                  child: VerticalSpace.custom(100),
                ),
              if (!isLast) VerticalSpace.xxlarge(),
            ],
          );
        },
      ),
    );
  }
}

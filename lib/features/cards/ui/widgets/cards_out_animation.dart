import 'package:flutter/material.dart';
import 'package:montebit/core/domain/entities/card_entity.dart';
import 'package:montebit/features/cards/ui/widgets/card_item.dart';

class CardsOutAnimation extends StatelessWidget {
  const CardsOutAnimation({
    super.key,
    required this.animation,
    required this.card,
  });

  final Animation<double> animation;
  final CardEntity card;

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    );

    return SizeTransition(
      sizeFactor: curved,
      axisAlignment: -1,
      child: SlideTransition(
        position: curved.drive(
          Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ),
        ),
        child: FadeTransition(
          opacity: curved,
          child: CardItem(
            card: card,
            showDeleteButton: false,
          ),
        ),
      ),
    );
  }
}

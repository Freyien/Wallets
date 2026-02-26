part of 'cards_bloc.dart';

sealed class CardsEvent {
  CardsEvent();
}

class GetCardsEvent extends CardsEvent {}

class DeleteCardEvent extends CardsEvent {
  DeleteCardEvent(this.id);
  final String id;
}

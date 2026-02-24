part of 'cards_bloc.dart';

sealed class CardsEvent extends Equatable {
  const CardsEvent();

  @override
  List<Object> get props => [];
}

class GetCardsEvent extends CardsEvent {}

class DeleteCardEvent extends CardsEvent {
  const DeleteCardEvent(this.id);
  final int id;

  @override
  List<Object> get props => [id];
}

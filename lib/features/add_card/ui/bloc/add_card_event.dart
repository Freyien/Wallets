part of 'add_card_bloc.dart';

sealed class AddCardEvent extends Equatable {
  const AddCardEvent();

  @override
  List<Object> get props => [];
}

class ChangeDescriptionEvent extends AddCardEvent {
  const ChangeDescriptionEvent(this.description);
  final String description;

  @override
  List<Object> get props => [description];
}

class ChangeCardNumberEvent extends AddCardEvent {
  const ChangeCardNumberEvent(this.cardNumber);
  final String cardNumber;

  @override
  List<Object> get props => [cardNumber];
}

class ChangeCardHolderEvent extends AddCardEvent {
  const ChangeCardHolderEvent(this.cardHolder);
  final String cardHolder;

  @override
  List<Object> get props => [cardHolder];
}

class ChangeValidityEvent extends AddCardEvent {
  const ChangeValidityEvent(this.validity);
  final String validity;

  @override
  List<Object> get props => [validity];
}

class ChangeCodeEvent extends AddCardEvent {
  const ChangeCodeEvent(this.code);
  final String code;

  @override
  List<Object> get props => [code];
}

class ChangeCardTypeEvent extends AddCardEvent {
  const ChangeCardTypeEvent(this.cardType);
  final String cardType;

  @override
  List<Object> get props => [cardType];
}

class ChangeCardTypeProcessorEvent extends AddCardEvent {
  const ChangeCardTypeProcessorEvent(this.cardTypeProcessor);
  final String cardTypeProcessor;

  @override
  List<Object> get props => [cardTypeProcessor];
}

class SaveCardEvent extends AddCardEvent {}

part of 'add_card_bloc.dart';

sealed class AddCardEvent {
  AddCardEvent();
}

class ChangeDescriptionEvent extends AddCardEvent {
  ChangeDescriptionEvent(this.description);
  final String description;
}

class ChangeCardNumberEvent extends AddCardEvent {
  ChangeCardNumberEvent(this.cardNumber);
  final String cardNumber;
}

class ChangeCardHolderEvent extends AddCardEvent {
  ChangeCardHolderEvent(this.cardHolder);
  final String cardHolder;
}

class ChangeValidityEvent extends AddCardEvent {
  ChangeValidityEvent(this.validity);
  final String validity;
}

class ChangeCodeEvent extends AddCardEvent {
  ChangeCodeEvent(this.code);
  final String code;
}

class ChangeCardTypeEvent extends AddCardEvent {
  ChangeCardTypeEvent(this.cardType);
  final CardType cardType;
}

class ChangeCardTypeProcessorEvent extends AddCardEvent {
  ChangeCardTypeProcessorEvent(this.cardTypeProcessor);
  final String cardTypeProcessor;
}

class SaveCardEvent extends AddCardEvent {}

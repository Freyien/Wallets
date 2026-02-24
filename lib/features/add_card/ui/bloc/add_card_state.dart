part of 'add_card_bloc.dart';

class AddCardState extends Equatable {
  const AddCardState({
    required this.fetchingStatus,
    required this.savingStatus,
    required this.addCard,
  });

  final FetchingStatus fetchingStatus;
  final SavingStatus savingStatus;
  final CardEntity addCard;

  factory AddCardState.initial() => AddCardState(
    fetchingStatus: FetchingStatus.initial,
    savingStatus: SavingStatus.initial,
    addCard: CardEntity.initial(),
  );

  AddCardState copyWith({
    FetchingStatus? fetchingStatus,
    SavingStatus? savingStatus,
    CardEntity? addCard,
  }) {
    return AddCardState(
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      savingStatus: savingStatus ?? this.savingStatus,
      addCard: addCard ?? this.addCard,
    );
  }

  @override
  List<Object> get props => [fetchingStatus, savingStatus, addCard];
}

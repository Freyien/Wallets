part of 'cards_bloc.dart';

class CardsState extends Equatable {
  const CardsState({
    required this.fetchingStatus,
    required this.savingStatus,
    required this.cards,
  });

  final FetchingStatus fetchingStatus;
  final SavingStatus savingStatus;
  final List<CardEntity> cards;

  factory CardsState.initial() => const CardsState(
    fetchingStatus: FetchingStatus.initial,
    savingStatus: SavingStatus.initial,
    cards: [],
  );

  CardsState copyWith({
    FetchingStatus? fetchingStatus,
    SavingStatus? savingStatus,
    List<CardEntity>? cards,
  }) {
    return CardsState(
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      savingStatus: savingStatus ?? this.savingStatus,
      cards: cards ?? this.cards,
    );
  }

  @override
  List<Object> get props => [fetchingStatus, savingStatus, cards];
}

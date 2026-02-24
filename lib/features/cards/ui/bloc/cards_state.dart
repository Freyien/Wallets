part of 'cards_bloc.dart';

class CardsState extends Equatable {
  const CardsState({
    required this.fetchingStatus,
    required this.savingStatus,
    required this.deletingStatus,
    required this.cards,
  });

  final FetchingStatus fetchingStatus;
  final SavingStatus savingStatus;
  final DeletingStatus deletingStatus;
  final List<CardEntity> cards;

  factory CardsState.initial() => const CardsState(
    fetchingStatus: FetchingStatus.initial,
    savingStatus: SavingStatus.initial,
    deletingStatus: DeletingStatus.initial,
    cards: [],
  );

  CardsState copyWith({
    FetchingStatus? fetchingStatus,
    SavingStatus? savingStatus,
    DeletingStatus? deletingStatus,
    List<CardEntity>? cards,
  }) {
    return CardsState(
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      savingStatus: savingStatus ?? this.savingStatus,
      deletingStatus: deletingStatus ?? this.deletingStatus,
      cards: cards ?? this.cards,
    );
  }

  @override
  List<Object> get props => [
    fetchingStatus,
    savingStatus,
    deletingStatus,
    cards,
  ];
}

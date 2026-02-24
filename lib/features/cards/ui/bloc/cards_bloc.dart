import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:montebit/core/domain/entities/card_entity.dart';
import 'package:montebit/core/domain/enums/deleting_status.dart';
import 'package:montebit/core/domain/enums/fetching_status.dart';
import 'package:montebit/core/domain/enums/saving_status.dart';
import 'package:montebit/features/cards/domain/repositories/cards_repository.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  final CardsRepository _repository;

  CardsBloc(this._repository) : super(CardsState.initial()) {
    on<GetCardsEvent>(_onGetCardsEvent);
    on<DeleteCardEvent>(_onDeleteCardEvent);
  }

  Future<void> _onGetCardsEvent(
    GetCardsEvent event,
    Emitter<CardsState> emit,
  ) async {
    emit(state.copyWith(fetchingStatus: FetchingStatus.loading));

    final result = await _repository.getCards();

    if (result.isSuccess) {
      return emit(
        state.copyWith(
          fetchingStatus: FetchingStatus.success,
          cards: result.data,
        ),
      );
    }

    emit(state.copyWith(fetchingStatus: FetchingStatus.failure));
  }

  Future<void> _onDeleteCardEvent(
    DeleteCardEvent event,
    Emitter<CardsState> emit,
  ) async {
    emit(state.copyWith(deletingStatus: DeletingStatus.loading));

    final result = await _repository.deleteCard(event.id);

    if (result.isSuccess) {
      final updatedCards = state.cards
          .where((card) => card.id != event.id)
          .toList();
      return emit(
        state.copyWith(
          deletingStatus: DeletingStatus.success,
          cards: updatedCards,
        ),
      );
    }

    emit(state.copyWith(deletingStatus: DeletingStatus.failure));
  }
}

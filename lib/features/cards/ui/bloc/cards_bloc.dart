import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:montebit/core/domain/entities/card_entity.dart';
import 'package:montebit/core/domain/enums/fetching_status.dart';
import 'package:montebit/core/domain/enums/saving_status.dart';
import 'package:montebit/features/cards/domain/repositories/cards_repository.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  final CardsRepository _repository;

  CardsBloc(this._repository) : super(CardsState.initial()) {
    on<GetCardsEvent>(_onGetCardsEvent);
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
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:montebit/core/domain/entities/card_entity.dart';
import 'package:montebit/core/domain/enums/fetching_status.dart';
import 'package:montebit/core/domain/enums/saving_status.dart';
import 'package:montebit/features/add_card/domain/repositories/add_card_repository.dart';

part 'add_card_event.dart';
part 'add_card_state.dart';

class AddCardBloc extends Bloc<AddCardEvent, AddCardState> {
  final AddCardRepository _repository;

  AddCardBloc(this._repository) : super(AddCardState.initial()) {
    on<ChangeDescriptionEvent>(_onDescriptionChanged);
    on<ChangeCardNumberEvent>(_onNumberChanged);
    on<ChangeCardHolderEvent>(_onHolderChanged);
    on<ChangeValidityEvent>(_onValidityChanged);
    on<ChangeCodeEvent>(_onCodeChanged);
    on<ChangeCardTypeEvent>(_onTypeChanged);
    on<ChangeCardTypeProcessorEvent>(_onTypeProcessorChanged);
    on<SaveCardEvent>(_onSaveCardEvent);
  }

  void _onDescriptionChanged(
    ChangeDescriptionEvent event,
    Emitter<AddCardState> emit,
  ) {
    emit(
      state.copyWith(
        addCard: state.addCard.copyWith(description: event.description),
      ),
    );
  }

  void _onNumberChanged(
    ChangeCardNumberEvent event,
    Emitter<AddCardState> emit,
  ) {
    emit(
      state.copyWith(
        addCard: state.addCard.copyWith(cardNumber: event.cardNumber),
      ),
    );
  }

  void _onHolderChanged(
    ChangeCardHolderEvent event,
    Emitter<AddCardState> emit,
  ) {
    emit(
      state.copyWith(
        addCard: state.addCard.copyWith(cardHolder: event.cardHolder),
      ),
    );
  }

  void _onValidityChanged(
    ChangeValidityEvent event,
    Emitter<AddCardState> emit,
  ) {
    emit(
      state.copyWith(addCard: state.addCard.copyWith(validity: event.validity)),
    );
  }

  void _onCodeChanged(ChangeCodeEvent event, Emitter<AddCardState> emit) {
    emit(state.copyWith(addCard: state.addCard.copyWith(code: event.code)));
  }

  void _onTypeChanged(ChangeCardTypeEvent event, Emitter<AddCardState> emit) {
    emit(
      state.copyWith(addCard: state.addCard.copyWith(cardType: event.cardType)),
    );
  }

  void _onTypeProcessorChanged(
    ChangeCardTypeProcessorEvent event,
    Emitter<AddCardState> emit,
  ) {
    emit(
      state.copyWith(
        addCard: state.addCard.copyWith(
          cardTypeProcessor: ProcessorType.fromString(event.cardTypeProcessor),
        ),
      ),
    );
  }

  Future<void> _onSaveCardEvent(
    SaveCardEvent event,
    Emitter<AddCardState> emit,
  ) async {
    emit(state.copyWith(fetchingStatus: FetchingStatus.loading));

    final result = await _repository.saveCard();

    if (result.isSuccess) {
      return emit(
        state.copyWith(
          fetchingStatus: FetchingStatus.success,
          addCard: result.data,
        ),
      );
    }

    emit(state.copyWith(fetchingStatus: FetchingStatus.failure));
  }
}

import 'package:bloc/bloc.dart';
import 'package:montebit/core/domain/enums/fetching_status.dart';
import 'package:montebit/features/logout/domain/repositories/logout_repository.dart';
import 'package:montebit/features/logout/ui/bloc/logout_event.dart';
import 'package:montebit/features/logout/ui/bloc/logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogoutRepository _repository;

  LogoutBloc(this._repository) : super(LogoutState.initial()) {
    on<PerformLogoutEvent>(_onPerformLogoutEvent);
  }

  Future<void> _onPerformLogoutEvent(
    PerformLogoutEvent event,
    Emitter<LogoutState> emit,
  ) async {
    emit(state.copyWith(logoutStatus: FetchingStatus.loading));

    final result = await _repository.logout();

    if (result.isSuccess) {
      return emit(state.copyWith(logoutStatus: FetchingStatus.success));
    }

    emit(state.copyWith(logoutStatus: FetchingStatus.failure));
  }
}

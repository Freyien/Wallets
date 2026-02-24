
import 'package:bloc/bloc.dart';
import 'package:montebit/core/domain/enums/fetching_status.dart';
import 'package:montebit/core/domain/enums/saving_status.dart';
import 'package:montebit/features/login/domain/entities/login_entity.dart';
import 'package:montebit/features/login/domain/repositories/login_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _repository;

  LoginBloc(this._repository) : super(LoginState.initial()) {
    on<GetLoginEvent>(_onGetLoginEvent);
  }

  Future<void> _onGetLoginEvent(
    GetLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(fetchingStatus: FetchingStatus.loading));

    final result = await _repository.getLogin();

    if (result.isSuccess) {
      return emit(state.copyWith(
        fetchingStatus: FetchingStatus.success,
        login: result.data,
      ));
    }

    emit(state.copyWith(fetchingStatus: FetchingStatus.failure));
  }
}

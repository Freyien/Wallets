import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:montebit/core/domain/enums/fetching_status.dart';
import 'package:montebit/core/domain/enums/saving_status.dart';
import 'package:montebit/core/domain/failures/failure.dart';
import 'package:montebit/features/login/domain/entities/login_entity.dart';
import 'package:montebit/features/login/domain/repositories/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _repository;

  LoginBloc(this._repository) : super(LoginState.initial()) {
    on<ChangeEmailEvent>(_onChangeEmailEvent);
    on<ChangePasswordEvent>(_onChangePasswordEvent);
    on<DoLoginEvent>(_onDoLoginEvent);
  }

  void _onChangeEmailEvent(ChangeEmailEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(login: state.login.copyWith(email: event.email)));
  }

  void _onChangePasswordEvent(
    ChangePasswordEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(login: state.login.copyWith(password: event.password)));
  }

  Future<void> _onDoLoginEvent(
    DoLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(fetchingStatus: FetchingStatus.loading));

    final result = await _repository.login(state.login);

    if (result.isSuccess) {
      return emit(state.copyWith(fetchingStatus: FetchingStatus.success));
    }

    emit(
      state.copyWith(
        fetchingStatus: FetchingStatus.failure,
        failure: result.failure,
      ),
    );
  }
}

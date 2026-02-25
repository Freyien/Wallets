import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:montebit/core/domain/enums/saving_status.dart';
import 'package:montebit/core/domain/failures/failure.dart';
import 'package:montebit/features/signup/domain/entities/signup_entity.dart';
import 'package:montebit/features/signup/domain/repositories/signup_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupRepository _repository;

  SignupBloc(this._repository) : super(SignupState.initial()) {
    on<DoSignupEvent>(_onDoSignupEvent);
    on<ChangeNickNameEvent>(_onChangeNickName);
    on<ChangeEmailEvent>(_onChangeEmail);
    on<ChangePhoneEvent>(_onChangePhone);
    on<ChangePasswordEvent>(_onChangePassword);
    on<ChangeConfirmPasswordEvent>(_onChangeConfirmPassword);
  }

  void _onChangeNickName(ChangeNickNameEvent event, Emitter<SignupState> emit) {
    emit(
      state.copyWith(signup: state.signup.copyWith(fullname: event.nickname)),
    );
  }

  void _onChangeEmail(ChangeEmailEvent event, Emitter<SignupState> emit) {
    emit(state.copyWith(signup: state.signup.copyWith(email: event.email)));
  }

  void _onChangePhone(ChangePhoneEvent event, Emitter<SignupState> emit) {
    emit(state.copyWith(signup: state.signup.copyWith(phone: event.phone)));
  }

  void _onChangePassword(ChangePasswordEvent event, Emitter<SignupState> emit) {
    emit(
      state.copyWith(signup: state.signup.copyWith(password: event.password)),
    );
  }

  void _onChangeConfirmPassword(
    ChangeConfirmPasswordEvent event,
    Emitter<SignupState> emit,
  ) {
    emit(
      state.copyWith(
        signup: state.signup.copyWith(confirmPassword: event.confirmPassword),
      ),
    );
  }

  Future<void> _onDoSignupEvent(
    DoSignupEvent event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(savingStatus: SavingStatus.loading));

    final result = await _repository.signUp(state.signup);

    if (result.isSuccess) {
      return emit(state.copyWith(savingStatus: SavingStatus.success));
    }

    emit(
      state.copyWith(
        savingStatus: SavingStatus.failure,
        failure: result.failure,
      ),
    );
  }
}

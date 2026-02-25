part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    required this.fetchingStatus,
    required this.savingStatus,
    required this.login,
    required this.failure,
  });

  final FetchingStatus fetchingStatus;
  final SavingStatus savingStatus;
  final LoginEntity login;
  final Failure failure;

  factory LoginState.initial() => LoginState(
    fetchingStatus: FetchingStatus.initial,
    savingStatus: SavingStatus.initial,
    login: LoginEntity.initial(),
    failure: NoneFailure(),
  );

  LoginState copyWith({
    FetchingStatus? fetchingStatus,
    SavingStatus? savingStatus,
    LoginEntity? login,
    Failure? failure,
  }) {
    return LoginState(
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      savingStatus: savingStatus ?? this.savingStatus,
      login: login ?? this.login,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object> get props => [fetchingStatus, savingStatus, login, failure];
}

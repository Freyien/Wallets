
part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    required this.fetchingStatus,
    required this.savingStatus,
    required this.login,
  });

  final FetchingStatus fetchingStatus;
  final SavingStatus savingStatus;
  final LoginEntity login;

  factory LoginState.initial() => LoginState(
        fetchingStatus: FetchingStatus.initial,
        savingStatus: SavingStatus.initial,
        login: LoginEntity.initial(),
      );


  LoginState copyWith({
    FetchingStatus? fetchingStatus,
    SavingStatus? savingStatus,
    LoginEntity? login,
  }) {
    return LoginState(
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      savingStatus: savingStatus ?? this.savingStatus,
      login: login ?? this.login,
    );
  }

  @override
  List<Object> get props => [fetchingStatus, savingStatus, login,];
}


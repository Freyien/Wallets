part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class ChangeEmailEvent extends LoginEvent {
  const ChangeEmailEvent(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class ChangePasswordEvent extends LoginEvent {
  const ChangePasswordEvent(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

class DoLoginEvent extends LoginEvent {}

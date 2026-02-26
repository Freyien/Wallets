part of 'login_bloc.dart';

sealed class LoginEvent {
  LoginEvent();
}

class ChangeEmailEvent extends LoginEvent {
  ChangeEmailEvent(this.email);
  final String email;
}

class ChangePasswordEvent extends LoginEvent {
  ChangePasswordEvent(this.password);
  final String password;
}

class DoLoginEvent extends LoginEvent {}

part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class DoSignupEvent extends SignupEvent {}

class ChangeNickNameEvent extends SignupEvent {
  final String nickname;
  const ChangeNickNameEvent(this.nickname);
  @override
  List<Object> get props => [nickname];
}

class ChangeEmailEvent extends SignupEvent {
  final String email;
  const ChangeEmailEvent(this.email);
  @override
  List<Object> get props => [email];
}

class ChangePhoneEvent extends SignupEvent {
  final String phone;
  const ChangePhoneEvent(this.phone);
  @override
  List<Object> get props => [phone];
}

class ChangePasswordEvent extends SignupEvent {
  final String password;
  const ChangePasswordEvent(this.password);
  @override
  List<Object> get props => [password];
}

class ChangeConfirmPasswordEvent extends SignupEvent {
  final String confirmPassword;
  const ChangeConfirmPasswordEvent(this.confirmPassword);
  @override
  List<Object> get props => [confirmPassword];
}

part of 'signup_bloc.dart';

sealed class SignupEvent {
  SignupEvent();
}

class DoSignupEvent extends SignupEvent {}

class ChangeNickNameEvent extends SignupEvent {
  final String nickname;
  ChangeNickNameEvent(this.nickname);
}

class ChangeEmailEvent extends SignupEvent {
  final String email;
  ChangeEmailEvent(this.email);
}

class ChangePhoneEvent extends SignupEvent {
  final String phone;
  ChangePhoneEvent(this.phone);
}

class ChangePasswordEvent extends SignupEvent {
  final String password;
  ChangePasswordEvent(this.password);
}

class ChangeConfirmPasswordEvent extends SignupEvent {
  final String confirmPassword;
  ChangeConfirmPasswordEvent(this.confirmPassword);
}

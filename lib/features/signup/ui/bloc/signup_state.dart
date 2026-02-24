part of 'signup_bloc.dart';

class SignupState extends Equatable {
  const SignupState({required this.savingStatus, required this.signup});

  final SavingStatus savingStatus;
  final SignupEntity signup;

  factory SignupState.initial() => SignupState(
    savingStatus: SavingStatus.initial,
    signup: SignupEntity.initial(),
  );

  SignupState copyWith({SavingStatus? savingStatus, SignupEntity? signup}) {
    return SignupState(
      savingStatus: savingStatus ?? this.savingStatus,
      signup: signup ?? this.signup,
    );
  }

  @override
  List<Object> get props => [savingStatus, signup];
}

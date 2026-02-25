part of 'signup_bloc.dart';

class SignupState extends Equatable {
  const SignupState({
    required this.savingStatus,
    required this.signup,
    required this.failure,
  });

  final SavingStatus savingStatus;
  final SignupEntity signup;
  final Failure failure;

  factory SignupState.initial() => SignupState(
    savingStatus: SavingStatus.initial,
    signup: SignupEntity.initial(),
    failure: NoneFailure(),
  );

  SignupState copyWith({
    SavingStatus? savingStatus,
    SignupEntity? signup,
    Failure? failure,
  }) {
    return SignupState(
      savingStatus: savingStatus ?? this.savingStatus,
      signup: signup ?? this.signup,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object> get props => [savingStatus, signup, failure];
}

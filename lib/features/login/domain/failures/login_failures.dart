import 'package:montebit/core/domain/failures/failure.dart';

class InvalidCredentialsFailure extends Failure {
  InvalidCredentialsFailure();
}

class UserLockedFailure extends Failure {
  UserLockedFailure();
}

class MaxAttemptsExceededFailure extends Failure {
  MaxAttemptsExceededFailure();
}

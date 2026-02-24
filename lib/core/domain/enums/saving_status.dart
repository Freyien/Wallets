enum SavingStatus { initial, loading, success, failure }

extension SavingStatusExtensions on SavingStatus {
  bool get isInitial => this == SavingStatus.initial;
  bool get isLoading => this == SavingStatus.loading;
  bool get isFailure => this == SavingStatus.failure;
  bool get isSuccess => this == SavingStatus.success;
  bool get isInitialOrLoading => isInitial || isLoading;
  bool get isInitialOrFailed => isInitial || isFailure;
}

enum DeletingStatus { initial, loading, success, failure }

extension DeletingStatusExtensions on DeletingStatus {
  bool get isInitial => this == DeletingStatus.initial;
  bool get isLoading => this == DeletingStatus.loading;
  bool get isFailure => this == DeletingStatus.failure;
  bool get isSuccess => this == DeletingStatus.success;
  bool get isInitialOrLoading => isInitial || isLoading;
}

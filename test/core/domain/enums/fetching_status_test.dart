import 'package:flutter_test/flutter_test.dart';
import 'package:montebit/core/domain/enums/fetching_status.dart';

void main() {
  group('FetchingStatus', () {
    test('isInitial should be true only for initial', () {
      expect(FetchingStatus.initial.isInitial, isTrue);
      expect(FetchingStatus.loading.isInitial, isFalse);
      expect(FetchingStatus.success.isInitial, isFalse);
      expect(FetchingStatus.failure.isInitial, isFalse);
    });

    test('isLoading should be true only for loading', () {
      expect(FetchingStatus.initial.isLoading, isFalse);
      expect(FetchingStatus.loading.isLoading, isTrue);
      expect(FetchingStatus.success.isLoading, isFalse);
      expect(FetchingStatus.failure.isLoading, isFalse);
    });

    test('isSuccess should be true only for success', () {
      expect(FetchingStatus.initial.isSuccess, isFalse);
      expect(FetchingStatus.loading.isSuccess, isFalse);
      expect(FetchingStatus.success.isSuccess, isTrue);
      expect(FetchingStatus.failure.isSuccess, isFalse);
    });

    test('isFailure should be true only for failure', () {
      expect(FetchingStatus.initial.isFailure, isFalse);
      expect(FetchingStatus.loading.isFailure, isFalse);
      expect(FetchingStatus.success.isFailure, isFalse);
      expect(FetchingStatus.failure.isFailure, isTrue);
    });

    test('isInitialOrLoading should be true only for initial or loading', () {
      expect(FetchingStatus.initial.isInitialOrLoading, isTrue);
      expect(FetchingStatus.loading.isInitialOrLoading, isTrue);
      expect(FetchingStatus.success.isInitialOrLoading, isFalse);
      expect(FetchingStatus.failure.isInitialOrLoading, isFalse);
    });
  });
}

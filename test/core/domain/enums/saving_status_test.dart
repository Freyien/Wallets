import 'package:flutter_test/flutter_test.dart';
import 'package:montebit/core/domain/enums/saving_status.dart';

void main() {
  group('SavingStatus', () {
    test('isInitial should be true only for initial', () {
      expect(SavingStatus.initial.isInitial, isTrue);
      expect(SavingStatus.loading.isInitial, isFalse);
      expect(SavingStatus.success.isInitial, isFalse);
      expect(SavingStatus.failure.isInitial, isFalse);
    });

    test('isLoading should be true only for loading', () {
      expect(SavingStatus.initial.isLoading, isFalse);
      expect(SavingStatus.loading.isLoading, isTrue);
      expect(SavingStatus.success.isLoading, isFalse);
      expect(SavingStatus.failure.isLoading, isFalse);
    });

    test('isSuccess should be true only for success', () {
      expect(SavingStatus.initial.isSuccess, isFalse);
      expect(SavingStatus.loading.isSuccess, isFalse);
      expect(SavingStatus.success.isSuccess, isTrue);
      expect(SavingStatus.failure.isSuccess, isFalse);
    });

    test('isFailure should be true only for failure', () {
      expect(SavingStatus.initial.isFailure, isFalse);
      expect(SavingStatus.loading.isFailure, isFalse);
      expect(SavingStatus.success.isFailure, isFalse);
      expect(SavingStatus.failure.isFailure, isTrue);
    });

    test('isInitialOrLoading should be true only for initial or loading', () {
      expect(SavingStatus.initial.isInitialOrLoading, isTrue);
      expect(SavingStatus.loading.isInitialOrLoading, isTrue);
      expect(SavingStatus.success.isInitialOrLoading, isFalse);
      expect(SavingStatus.failure.isInitialOrLoading, isFalse);
    });

    test('isInitialOrFailed should be true only for initial or failure', () {
      expect(SavingStatus.initial.isInitialOrFailed, isTrue);
      expect(SavingStatus.loading.isInitialOrFailed, isFalse);
      expect(SavingStatus.success.isInitialOrFailed, isFalse);
      expect(SavingStatus.failure.isInitialOrFailed, isTrue);
    });
  });
}

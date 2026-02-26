import 'package:flutter_test/flutter_test.dart';
import 'package:montebit/core/domain/enums/deleting_status.dart';

void main() {
  group('DeletingStatus', () {
    test('isInitial should be true only for initial', () {
      expect(DeletingStatus.initial.isInitial, isTrue);
      expect(DeletingStatus.loading.isInitial, isFalse);
      expect(DeletingStatus.success.isInitial, isFalse);
      expect(DeletingStatus.failure.isInitial, isFalse);
    });

    test('isLoading should be true only for loading', () {
      expect(DeletingStatus.initial.isLoading, isFalse);
      expect(DeletingStatus.loading.isLoading, isTrue);
      expect(DeletingStatus.success.isLoading, isFalse);
      expect(DeletingStatus.failure.isLoading, isFalse);
    });

    test('isSuccess should be true only for success', () {
      expect(DeletingStatus.initial.isSuccess, isFalse);
      expect(DeletingStatus.loading.isSuccess, isFalse);
      expect(DeletingStatus.success.isSuccess, isTrue);
      expect(DeletingStatus.failure.isSuccess, isFalse);
    });

    test('isFailure should be true only for failure', () {
      expect(DeletingStatus.initial.isFailure, isFalse);
      expect(DeletingStatus.loading.isFailure, isFalse);
      expect(DeletingStatus.success.isFailure, isFalse);
      expect(DeletingStatus.failure.isFailure, isTrue);
    });

    test('isInitialOrLoading should be true only for initial or loading', () {
      expect(DeletingStatus.initial.isInitialOrLoading, isTrue);
      expect(DeletingStatus.loading.isInitialOrLoading, isTrue);
      expect(DeletingStatus.success.isInitialOrLoading, isFalse);
      expect(DeletingStatus.failure.isInitialOrLoading, isFalse);
    });
  });
}

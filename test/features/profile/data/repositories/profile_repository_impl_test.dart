import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:montebit/core/domain/failures/failure.dart';
import 'package:montebit/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:montebit/features/profile/domain/datasources/profile_datasource.dart';
import 'package:montebit/features/profile/domain/entities/profile_entity.dart';

class MockProfileDatasource extends Mock implements ProfileDatasource {}

void main() {
  late ProfileRepositoryImpl repository;
  late MockProfileDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockProfileDatasource();
    repository = ProfileRepositoryImpl(mockDatasource);
  });

  const tProfileEntity = ProfileEntity(
    id: '1',
    fullName: 'Test User',
    email: 'test@test.com',
    phone: '1234567890',
    imageUrl: 'https://example.com/image.png',
  );

  group('getProfile', () {
    test(
      'should return Success Response when getting profile is successful',
      () async {
        // arrange
        when(
          () => mockDatasource.getProfile(),
        ).thenAnswer((_) async => tProfileEntity);

        // act
        final result = await repository.getProfile();

        // assert
        expect(result.isSuccess, true);
        expect(result.data, equals(tProfileEntity));
        verify(() => mockDatasource.getProfile()).called(1);
      },
    );

    test(
      'should return Failed Response with UnexpectedFailure on a generic Exception',
      () async {
        // arrange
        when(() => mockDatasource.getProfile()).thenThrow(Exception());

        // act
        final result = await repository.getProfile();

        // assert
        expect(result.isFailed, true);
        expect(result.failure, isA<UnexpectedFailure>());
        verify(() => mockDatasource.getProfile()).called(1);
      },
    );
  });
}

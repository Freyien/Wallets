import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:montebit/core/domain/failures/failure.dart';
import 'package:montebit/features/login/data/repositories/login_repository_impl.dart';
import 'package:montebit/features/login/domain/datasources/login_datasource.dart';
import 'package:montebit/features/login/domain/entities/login_entity.dart';
import 'package:montebit/features/login/domain/entities/login_response_entity.dart';
import 'package:montebit/features/login/domain/exceptions/login_exceptions.dart';
import 'package:montebit/features/login/domain/failures/login_failures.dart';

class MockLoginDatasource extends Mock implements LoginDatasource {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late LoginRepositoryImpl repository;
  late MockLoginDatasource mockDatasource;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockDatasource = MockLoginDatasource();
    mockSecureStorage = MockFlutterSecureStorage();
    repository = LoginRepositoryImpl(mockDatasource, mockSecureStorage);
  });

  final tLoginEntity = const LoginEntity(
    email: 'test@test.com',
    password: 'password123',
  );
  final tLoginResponseEntity = const LoginResponseEntity(token: 'valid_token');

  group('login', () {
    test(
      'should return Success Response and save token when login is successful',
      () async {
        // arrange
        when(
          () => mockDatasource.login(tLoginEntity),
        ).thenAnswer((_) async => tLoginResponseEntity);
        when(
          () => mockSecureStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async {});

        // act
        final result = await repository.login(tLoginEntity);

        // assert
        expect(result.isSuccess, true);
        expect(result.data, equals(tLoginResponseEntity));
        verify(
          () => mockSecureStorage.write(
            key: 'token',
            value: tLoginResponseEntity.token,
          ),
        ).called(1);
      },
    );

    test(
      'should return Failed Response with InvalidCredentialsFailure on InvalidCredentialsException',
      () async {
        // arrange
        when(
          () => mockDatasource.login(tLoginEntity),
        ).thenThrow(InvalidCredentialsException());

        // act
        final result = await repository.login(tLoginEntity);

        // assert
        expect(result.isFailed, true);
        expect(result.failure, isA<InvalidCredentialsFailure>());
        verifyNever(
          () => mockSecureStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        );
      },
    );

    test(
      'should return Failed Response with UserLockedFailure on UserLockedException',
      () async {
        // arrange
        when(
          () => mockDatasource.login(tLoginEntity),
        ).thenThrow(UserLockedException());

        // act
        final result = await repository.login(tLoginEntity);

        // assert
        expect(result.isFailed, true);
        expect(result.failure, isA<UserLockedFailure>());
        verifyNever(
          () => mockSecureStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        );
      },
    );

    test(
      'should return Failed Response with MaxAttemptsExceededFailure on MaxAttemptsExceededException',
      () async {
        // arrange
        when(
          () => mockDatasource.login(tLoginEntity),
        ).thenThrow(MaxAttemptsExceededException());

        // act
        final result = await repository.login(tLoginEntity);

        // assert
        expect(result.isFailed, true);
        expect(result.failure, isA<MaxAttemptsExceededFailure>());
        verifyNever(
          () => mockSecureStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        );
      },
    );

    test(
      'should return Failed Response with UnexpectedFailure on a generic Exception',
      () async {
        // arrange
        when(() => mockDatasource.login(tLoginEntity)).thenThrow(Exception());

        // act
        final result = await repository.login(tLoginEntity);

        // assert
        expect(result.isFailed, true);
        expect(result.failure, isA<UnexpectedFailure>());
        verifyNever(
          () => mockSecureStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        );
      },
    );
  });
}

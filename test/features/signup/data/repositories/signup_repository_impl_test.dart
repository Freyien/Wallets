import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:montebit/core/domain/failures/failure.dart';
import 'package:montebit/features/signup/data/repositories/signup_repository_impl.dart';
import 'package:montebit/features/signup/domain/datasources/signup_datasource.dart';
import 'package:montebit/features/signup/domain/entities/signup_entity.dart';
import 'package:montebit/features/signup/domain/entities/signup_response_entity.dart';
import 'package:montebit/features/signup/domain/exceptions/signup_exceptions.dart';
import 'package:montebit/features/signup/domain/failures/signup_failures.dart';

class MockSignupDatasource extends Mock implements SignupDatasource {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late SignupRepositoryImpl repository;
  late MockSignupDatasource mockDatasource;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockDatasource = MockSignupDatasource();
    mockSecureStorage = MockFlutterSecureStorage();
    repository = SignupRepositoryImpl(mockDatasource, mockSecureStorage);
  });

  final tSignupEntity = const SignupEntity(
    fullname: 'Test User',
    email: 'test@test.com',
    dialCode: '+52',
    phone: '1234567890',
    password: 'password123',
    confirmPassword: 'password123',
  );
  final tSignupResponseEntity = const SignUpResponseEntity(
    token: 'valid_token',
  );

  group('signUp', () {
    test(
      'should return Success Response and save token when signup is successful',
      () async {
        // arrange
        when(
          () => mockDatasource.signUp(tSignupEntity),
        ).thenAnswer((_) async => tSignupResponseEntity);
        when(
          () => mockSecureStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async {});

        // act
        final result = await repository.signUp(tSignupEntity);

        // assert
        expect(result.isSuccess, true);
        expect(result.data, equals(tSignupResponseEntity));
        verify(
          () => mockSecureStorage.write(
            key: 'token',
            value: tSignupResponseEntity.token,
          ),
        ).called(1);
      },
    );

    test(
      'should return Failed Response with EmailOrPhoneAlreadyInUseFailure on Exception',
      () async {
        // arrange
        when(
          () => mockDatasource.signUp(tSignupEntity),
        ).thenThrow(EmailOrPhoneAlreadyInUseException());

        // act
        final result = await repository.signUp(tSignupEntity);

        // assert
        expect(result.isFailed, true);
        expect(result.failure, isA<EmailOrPhoneAlreadyInUseFailure>());
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
        when(() => mockDatasource.signUp(tSignupEntity)).thenThrow(Exception());

        // act
        final result = await repository.signUp(tSignupEntity);

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

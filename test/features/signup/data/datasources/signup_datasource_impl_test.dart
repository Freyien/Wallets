import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:montebit/features/signup/data/datasources/signup_datasource_impl.dart';
import 'package:montebit/features/signup/domain/entities/signup_entity.dart';
import 'package:montebit/features/signup/domain/entities/signup_response_entity.dart';
import 'package:montebit/features/signup/domain/exceptions/signup_exceptions.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late SignupDatasourceImpl datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = SignupDatasourceImpl(mockDio);
  });

  final tSignupEntity = const SignupEntity(
    fullname: 'Test User',
    email: 'test@test.com',
    dialCode: '+52',
    phone: '1234567890',
    password: 'password123',
    confirmPassword: 'password123',
  );

  final tSignupJson = tSignupEntity.toJson();
  final tSignupResponseEntity = const SignUpResponseEntity(
    token: 'valid_token',
  );

  group('signUp', () {
    test(
      'should return SignUpResponseEntity when the response code is 200/201',
      () async {
        // arrange
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/auth/register'),
            data: {
              'data': {
                'token': 'valid_token',
              },
            },
            statusCode: 201,
          ),
        );

        // act
        final result = await datasource.signUp(tSignupEntity);

        // assert
        expect(result, equals(tSignupResponseEntity));
        verify(
          () => mockDio.post(
            '/auth/register',
            data: tSignupJson,
          ),
        ).called(1);
      },
    );

    test(
      'should throw EmailOrPhoneAlreadyInUseException when response code is 412',
      () async {
        // arrange
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/auth/register'),
            response: Response(
              requestOptions: RequestOptions(path: '/auth/register'),
              statusCode: 412,
            ),
          ),
        );

        // act
        final call = datasource.signUp(tSignupEntity);

        // assert
        expect(() => call, throwsA(isA<EmailOrPhoneAlreadyInUseException>()));
      },
    );

    test('should throw Exception when a generic Exception occurs', () async {
      // arrange
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
        ),
      ).thenThrow(Exception());

      // act
      final call = datasource.signUp(tSignupEntity);

      // assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });
}

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:montebit/features/login/data/datasources/login_datasource_impl.dart';
import 'package:montebit/features/login/domain/entities/login_entity.dart';
import 'package:montebit/features/login/domain/entities/login_response_entity.dart';
import 'package:montebit/features/login/domain/exceptions/login_exceptions.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late LoginDatasourceImpl datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = LoginDatasourceImpl(mockDio);
  });

  final tLoginEntity = const LoginEntity(
    email: 'test@test.com',
    password: 'password123',
  );
  final tLoginJson = tLoginEntity.toJson();
  final tLoginResponseEntity = const LoginResponseEntity(token: 'valid_token');

  group('login', () {
    test(
      'should return LoginResponseEntity when the response code is 200/201',
      () async {
        // arrange
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/auth/login'),
            data: {
              'data': {
                'token': 'valid_token',
              },
            },
            statusCode: 200,
          ),
        );

        // act
        final result = await datasource.login(tLoginEntity);

        // assert
        expect(result, equals(tLoginResponseEntity));
        verify(
          () => mockDio.post(
            '/auth/login',
            data: tLoginJson,
          ),
        ).called(1);
      },
    );

    test(
      'should throw InvalidCredentialsException when response code is 401',
      () async {
        // arrange
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/auth/login'),
            response: Response(
              requestOptions: RequestOptions(path: '/auth/login'),
              statusCode: 401,
            ),
          ),
        );

        // act
        final call = datasource.login(tLoginEntity);

        // assert
        expect(() => call, throwsA(isA<InvalidCredentialsException>()));
      },
    );

    test(
      'should throw UserLockedException when response code is 403',
      () async {
        // arrange
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/auth/login'),
            response: Response(
              requestOptions: RequestOptions(path: '/auth/login'),
              statusCode: 403,
            ),
          ),
        );

        // act
        final call = datasource.login(tLoginEntity);

        // assert
        expect(() => call, throwsA(isA<UserLockedException>()));
      },
    );

    test(
      'should throw MaxAttemptsExceededException when response code is 429',
      () async {
        // arrange
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/auth/login'),
            response: Response(
              requestOptions: RequestOptions(path: '/auth/login'),
              statusCode: 429,
            ),
          ),
        );

        // act
        final call = datasource.login(tLoginEntity);

        // assert
        expect(() => call, throwsA(isA<MaxAttemptsExceededException>()));
      },
    );
  });
}

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:montebit/features/profile/data/datasources/profile_datasource_impl.dart';
import 'package:montebit/features/profile/domain/entities/profile_entity.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late ProfileDatasourceImpl datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = ProfileDatasourceImpl(mockDio);
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
      'should return a ProfileEntity when the response code is 200 (success)',
      () async {
        // arrange
        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/profile'),
            data: {
              'data': {
                'id': '1',
                'full_name': 'Test User',
                'email': 'test@test.com',
                'phone': '1234567890',
                'image_url': 'https://example.com/image.png',
              },
            },
            statusCode: 200,
          ),
        );

        // act
        final result = await datasource.getProfile();

        // assert
        expect(result, equals(tProfileEntity));
        verify(() => mockDio.get('/profile')).called(1);
      },
    );

    test('should throw Exception when a generic Exception occurs', () async {
      // arrange
      when(() => mockDio.get(any())).thenThrow(Exception());

      // act
      final call = datasource.getProfile();

      // assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });
}

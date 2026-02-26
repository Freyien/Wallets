import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:montebit/core/domain/entities/card_entity.dart';
import 'package:montebit/features/cards/data/datasources/cards_datasource_impl.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late CardsDatasourceImpl datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = CardsDatasourceImpl(mockDio);
  });

  final tCardEntity = CardEntity(
    id: '1',
    description: 'Test Card',
    type: CardType.debit,
    processor: ProcessorType.visa,
    number: '**** **** **** 1234',
    holder: 'John Doe',
    validity: '12/26',
    code: '123',
  );

  final tCardsList = [tCardEntity];

  group('getCards', () {
    test(
      'should return a list of CardEntity when the call is successful',
      () async {
        // arrange
        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/cards'),
            data: {
              'data': [
                {
                  'id': '1',
                  'description': 'Test Card',
                  'type': 'DEBIT',
                  'processor': 'VISA',
                  'last_four_digits': '1234',
                  'card_holder': 'John Doe',
                  'expiration_date': '12/26',
                  'code': '123',
                },
              ],
            },
            statusCode: 200,
          ),
        );

        // act
        final result = await datasource.getCards();

        // assert
        expect(result, equals(tCardsList));
        verify(() => mockDio.get('/cards')).called(1);
      },
    );

    test('should throw Exception when the call fails', () async {
      // arrange
      when(() => mockDio.get(any())).thenThrow(Exception());

      // act
      final call = datasource.getCards();

      // assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });

  group('deleteCard', () {
    test('should complete successfully when delete is requested', () async {
      // arrange
      when(() => mockDio.delete(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/cards/1'),
          statusCode: 200,
        ),
      );

      // act
      await datasource.deleteCard('1');

      // assert
      verify(() => mockDio.delete('/cards/1')).called(1);
    });

    test('should throw exceptionally if deletion fails', () async {
      // arrange
      when(() => mockDio.delete(any())).thenThrow(Exception());

      // act
      final call = datasource.deleteCard('1');

      // assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });
}

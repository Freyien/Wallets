import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:montebit/core/domain/entities/card_entity.dart';
import 'package:montebit/features/add_card/data/datasources/add_card_datasource_impl.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late AddCardDatasourceImpl datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = AddCardDatasourceImpl(mockDio);
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

  final tCardJson = tCardEntity.toJson();

  group('saveCard', () {
    test(
      'should return a card entity instance when the response code is 200 (success)',
      () async {
        // arrange
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/cards'),
            statusCode: 200,
          ),
        );

        // act
        final result = await datasource.saveCard(tCardEntity);

        // assert
        expect(
          result,
          equals(CardEntity.initial()),
        ); // returns CardEntity.initial()
        verify(() => mockDio.post('/cards', data: tCardJson)).called(1);
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
      final call = datasource.saveCard(tCardEntity);

      // assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });
}

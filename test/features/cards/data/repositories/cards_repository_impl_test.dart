import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:montebit/core/domain/entities/card_entity.dart';
import 'package:montebit/core/domain/failures/failure.dart';
import 'package:montebit/features/cards/data/repositories/cards_repository_impl.dart';
import 'package:montebit/features/cards/domain/datasources/cards_datasource.dart';

class MockCardsDatasource extends Mock implements CardsDatasource {}

void main() {
  late CardsRepositoryImpl repository;
  late MockCardsDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockCardsDatasource();
    repository = CardsRepositoryImpl(mockDatasource);
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
      'should return Success Response when getting cards is successful',
      () async {
        // arrange
        when(
          () => mockDatasource.getCards(),
        ).thenAnswer((_) async => tCardsList);

        // act
        final result = await repository.getCards();

        // assert
        expect(result.isSuccess, true);
        expect(result.data, equals(tCardsList));
        verify(() => mockDatasource.getCards()).called(1);
      },
    );

    test(
      'should return Failed Response with UnexpectedFailure on a generic Exception',
      () async {
        // arrange
        when(() => mockDatasource.getCards()).thenThrow(Exception());

        // act
        final result = await repository.getCards();

        // assert
        expect(result.isFailed, true);
        expect(result.failure, isA<UnexpectedFailure>());
        verify(() => mockDatasource.getCards()).called(1);
      },
    );
  });

  group('deleteCard', () {
    test(
      'should return void Success Response when deleting card is successful',
      () async {
        // arrange
        when(() => mockDatasource.deleteCard(any())).thenAnswer((_) async {});

        // act
        final result = await repository.deleteCard('1');

        // assert
        expect(result.isSuccess, true);
        verify(() => mockDatasource.deleteCard('1')).called(1);
      },
    );

    test(
      'should return Failed Response with UnexpectedFailure on DioException',
      () async {
        // arrange
        when(() => mockDatasource.deleteCard(any())).thenThrow(
          DioException(requestOptions: RequestOptions(path: '/cards/1')),
        );

        // act
        final result = await repository.deleteCard('1');

        // assert
        expect(result.isFailed, true);
        expect(result.failure, isA<UnexpectedFailure>());
        verify(() => mockDatasource.deleteCard('1')).called(1);
      },
    );

    test(
      'should return Failed Response with UnexpectedFailure on generic Exception',
      () async {
        // arrange
        when(() => mockDatasource.deleteCard(any())).thenThrow(Exception());

        // act
        final result = await repository.deleteCard('1');

        // assert
        expect(result.isFailed, true);
        expect(result.failure, isA<UnexpectedFailure>());
        verify(() => mockDatasource.deleteCard('1')).called(1);
      },
    );
  });
}

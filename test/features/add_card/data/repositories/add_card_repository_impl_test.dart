import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:montebit/core/domain/entities/card_entity.dart';
import 'package:montebit/core/domain/failures/failure.dart';
import 'package:montebit/features/add_card/data/repositories/add_card_repository_impl.dart';
import 'package:montebit/features/add_card/domain/datasources/add_card_datasource.dart';

class MockAddCardDatasource extends Mock implements AddCardDatasource {}

class FakeCardEntity extends Fake implements CardEntity {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeCardEntity());
  });

  late AddCardRepositoryImpl repository;
  late MockAddCardDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockAddCardDatasource();
    repository = AddCardRepositoryImpl(mockDatasource);
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

  group('saveCard', () {
    test(
      'should return Success Response when save card is successful',
      () async {
        // arrange
        when(
          () => mockDatasource.saveCard(any()),
        ).thenAnswer((_) async => CardEntity.initial());

        // act
        final result = await repository.saveCard(tCardEntity);

        // assert
        expect(result.isSuccess, true);
        expect(result.data, equals(CardEntity.initial()));
        verify(() => mockDatasource.saveCard(tCardEntity)).called(1);
      },
    );

    test(
      'should return Failed Response with UnexpectedFailure on a generic Exception',
      () async {
        // arrange
        when(() => mockDatasource.saveCard(any())).thenThrow(Exception());

        // act
        final result = await repository.saveCard(tCardEntity);

        // assert
        expect(result.isFailed, true);
        expect(result.failure, isA<UnexpectedFailure>());
        verify(() => mockDatasource.saveCard(tCardEntity)).called(1);
      },
    );
  });
}

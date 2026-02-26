import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:montebit/core/domain/entities/card_entity.dart';
import 'package:montebit/core/domain/entities/response.dart';
import 'package:montebit/core/domain/enums/deleting_status.dart';
import 'package:montebit/core/domain/enums/fetching_status.dart';
import 'package:montebit/core/domain/failures/failure.dart';
import 'package:montebit/features/cards/domain/repositories/cards_repository.dart';
import 'package:montebit/features/cards/ui/bloc/cards_bloc.dart';

class MockCardsRepository extends Mock implements CardsRepository {}

class FakeCardEntity extends Fake implements CardEntity {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeCardEntity());
  });

  late CardsBloc cardsBloc;
  late MockCardsRepository mockRepository;

  setUp(() {
    mockRepository = MockCardsRepository();
    cardsBloc = CardsBloc(mockRepository);
  });

  tearDown(() {
    cardsBloc.close();
  });

  final tCardEntity1 = CardEntity(
    id: '1',
    description: 'Test Card 1',
    type: CardType.debit,
    processor: ProcessorType.visa,
    number: '**** **** **** 1234',
    holder: 'John Doe',
    validity: '12/26',
    code: '123',
  );

  final tCardEntity2 = CardEntity(
    id: '2',
    description: 'Test Card 2',
    type: CardType.credit,
    processor: ProcessorType.mastercard,
    number: '**** **** **** 5678',
    holder: 'Jane Doe',
    validity: '11/25',
    code: '456',
  );

  final tCardsList = [tCardEntity1, tCardEntity2];

  test('initial state should be CardsState.initial()', () {
    expect(cardsBloc.state.fetchingStatus, equals(FetchingStatus.initial));
    expect(cardsBloc.state.deletingStatus, equals(DeletingStatus.initial));
    expect(cardsBloc.state.cards, isEmpty);
  });

  group('CardsEvent instantiation', () {
    test('supports instantiation and triggers constructors', () {
      expect(GetCardsEvent(), isA<GetCardsEvent>());
      expect(DeleteCardEvent('1').id, equals('1'));
    });
  });

  group('GetCardsEvent', () {
    blocTest<CardsBloc, CardsState>(
      'emits [loading, success] with cards list on successful fetch',
      build: () {
        when(() => mockRepository.getCards()).thenAnswer(
          (_) async => Response<List<CardEntity>>.success(tCardsList),
        );
        return cardsBloc;
      },
      act: (bloc) => bloc.add(GetCardsEvent()),
      expect: () => [
        isA<CardsState>().having(
          (s) => s.fetchingStatus,
          'fetchingStatus',
          FetchingStatus.loading,
        ),
        isA<CardsState>()
            .having(
              (s) => s.fetchingStatus,
              'fetchingStatus',
              FetchingStatus.success,
            )
            .having((s) => s.cards, 'cards', tCardsList),
      ],
    );

    blocTest<CardsBloc, CardsState>(
      'emits [loading, failure] on failed fetch',
      build: () {
        when(() => mockRepository.getCards()).thenAnswer(
          (_) async => Response<List<CardEntity>>.failed(UnexpectedFailure()),
        );
        return cardsBloc;
      },
      act: (bloc) => bloc.add(GetCardsEvent()),
      expect: () => [
        isA<CardsState>().having(
          (s) => s.fetchingStatus,
          'fetchingStatus',
          FetchingStatus.loading,
        ),
        isA<CardsState>().having(
          (s) => s.fetchingStatus,
          'fetchingStatus',
          FetchingStatus.failure,
        ),
      ],
    );
  });

  group('DeleteCardEvent', () {
    blocTest<CardsBloc, CardsState>(
      'emits [loading, success] and removes the card from state on successful delete',
      build: () {
        when(() => mockRepository.deleteCard('1')).thenAnswer(
          (_) async => Response<void>.voidSuccess(),
        );
        return cardsBloc;
      },
      seed: () => CardsState.initial().copyWith(
        cards: tCardsList,
        fetchingStatus: FetchingStatus.success,
      ),
      act: (bloc) => bloc.add(DeleteCardEvent('1')),
      expect: () => [
        isA<CardsState>()
            .having(
              (s) => s.deletingStatus,
              'deletingStatus',
              DeletingStatus.loading,
            )
            .having((s) => s.cards, 'cards', tCardsList),
        isA<CardsState>()
            .having(
              (s) => s.deletingStatus,
              'deletingStatus',
              DeletingStatus.success,
            )
            .having((s) => s.cards, 'cards', [tCardEntity2]),
      ],
    );

    blocTest<CardsBloc, CardsState>(
      'emits [loading, failure] on failed delete and retains cards list',
      build: () {
        when(() => mockRepository.deleteCard('1')).thenAnswer(
          (_) async => Response<void>.failed(UnexpectedFailure()),
        );
        return cardsBloc;
      },
      seed: () => CardsState.initial().copyWith(
        cards: tCardsList,
        fetchingStatus: FetchingStatus.success,
      ),
      act: (bloc) => bloc.add(DeleteCardEvent('1')),
      expect: () => [
        isA<CardsState>().having(
          (s) => s.deletingStatus,
          'deletingStatus',
          DeletingStatus.loading,
        ),
        isA<CardsState>()
            .having(
              (s) => s.deletingStatus,
              'deletingStatus',
              DeletingStatus.failure,
            )
            .having((s) => s.cards, 'cards', tCardsList),
      ],
    );
  });
}

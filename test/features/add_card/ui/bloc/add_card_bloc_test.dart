import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:montebit/core/domain/entities/card_entity.dart';
import 'package:montebit/core/domain/entities/response.dart';
import 'package:montebit/core/domain/enums/fetching_status.dart';
import 'package:montebit/core/domain/enums/saving_status.dart';
import 'package:montebit/core/domain/failures/failure.dart';
import 'package:montebit/features/add_card/domain/repositories/add_card_repository.dart';
import 'package:montebit/features/add_card/ui/bloc/add_card_bloc.dart';

class MockAddCardRepository extends Mock implements AddCardRepository {}

class FakeCardEntity extends Fake implements CardEntity {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeCardEntity());
  });

  late AddCardBloc addCardBloc;
  late MockAddCardRepository mockRepository;

  setUp(() {
    mockRepository = MockAddCardRepository();
    addCardBloc = AddCardBloc(mockRepository);
  });

  tearDown(() {
    addCardBloc.close();
  });

  test('initial state should be AddCardState.initial()', () {
    expect(addCardBloc.state.fetchingStatus, equals(FetchingStatus.initial));
    expect(addCardBloc.state.savingStatus, equals(SavingStatus.initial));
    expect(addCardBloc.state.addCard, equals(CardEntity.initial()));
  });

  group('Input Events', () {
    blocTest<AddCardBloc, AddCardState>(
      'emits updated description state on ChangeDescriptionEvent',
      build: () => addCardBloc,
      act: (bloc) => bloc.add(ChangeDescriptionEvent('Test Desc')),
      expect: () => [
        isA<AddCardState>().having(
          (s) => s.addCard.description,
          'description',
          'Test Desc',
        ),
      ],
    );

    blocTest<AddCardBloc, AddCardState>(
      'emits updated number state on ChangeCardNumberEvent',
      build: () => addCardBloc,
      act: (bloc) => bloc.add(ChangeCardNumberEvent('1234123412341234')),
      expect: () => [
        isA<AddCardState>().having(
          (s) => s.addCard.number,
          'number',
          '1234123412341234',
        ),
      ],
    );

    blocTest<AddCardBloc, AddCardState>(
      'emits updated holder state on ChangeCardHolderEvent',
      build: () => addCardBloc,
      act: (bloc) => bloc.add(ChangeCardHolderEvent('John Doe')),
      expect: () => [
        isA<AddCardState>().having(
          (s) => s.addCard.holder,
          'holder',
          'John Doe',
        ),
      ],
    );

    blocTest<AddCardBloc, AddCardState>(
      'emits formatted validity state on ChangeValidityEvent when YY is provided',
      build: () => addCardBloc,
      act: (bloc) => bloc.add(ChangeValidityEvent('12/26')),
      expect: () => [
        isA<AddCardState>().having(
          (s) => s.addCard.validity,
          'validity',
          '12/2026',
        ),
      ],
    );

    blocTest<AddCardBloc, AddCardState>(
      'emits unchanged validity state on ChangeValidityEvent when format is shorter',
      build: () => addCardBloc,
      act: (bloc) => bloc.add(ChangeValidityEvent('12/2')),
      expect: () => [
        isA<AddCardState>().having(
          (s) => s.addCard.validity,
          'validity',
          '12/2',
        ),
      ],
    );

    blocTest<AddCardBloc, AddCardState>(
      'emits updated code state on ChangeCodeEvent',
      build: () => addCardBloc,
      act: (bloc) => bloc.add(ChangeCodeEvent('123')),
      expect: () => [
        isA<AddCardState>().having((s) => s.addCard.code, 'code', '123'),
      ],
    );

    blocTest<AddCardBloc, AddCardState>(
      'emits updated type state on ChangeCardTypeEvent',
      build: () => addCardBloc,
      act: (bloc) => bloc.add(ChangeCardTypeEvent(CardType.debit)),
      expect: () => [
        isA<AddCardState>().having(
          (s) => s.addCard.type,
          'type',
          CardType.debit,
        ),
      ],
    );

    blocTest<AddCardBloc, AddCardState>(
      'emits updated processorType state on ChangeCardTypeProcessorEvent',
      build: () => addCardBloc,
      act: (bloc) => bloc.add(ChangeCardTypeProcessorEvent('visa')),
      expect: () => [
        isA<AddCardState>().having(
          (s) => s.addCard.processor,
          'processor',
          ProcessorType.visa,
        ),
      ],
    );
  });

  group('SaveCardEvent', () {
    blocTest<AddCardBloc, AddCardState>(
      'emits [loading, success] states on successful save',
      build: () {
        when(() => mockRepository.saveCard(any())).thenAnswer(
          (_) async => Response<CardEntity>.success(CardEntity.initial()),
        );
        return addCardBloc;
      },
      act: (bloc) => bloc.add(SaveCardEvent()),
      expect: () => [
        isA<AddCardState>().having(
          (s) => s.savingStatus,
          'savingStatus',
          SavingStatus.loading,
        ),
        isA<AddCardState>().having(
          (s) => s.savingStatus,
          'savingStatus',
          SavingStatus.success,
        ),
      ],
    );

    blocTest<AddCardBloc, AddCardState>(
      'emits [loading, failure] states on failed save',
      build: () {
        when(() => mockRepository.saveCard(any())).thenAnswer(
          (_) async => Response<CardEntity>.failed(UnexpectedFailure()),
        );
        return addCardBloc;
      },
      act: (bloc) => bloc.add(SaveCardEvent()),
      expect: () => [
        isA<AddCardState>().having(
          (s) => s.savingStatus,
          'savingStatus',
          SavingStatus.loading,
        ),
        isA<AddCardState>().having(
          (s) => s.savingStatus,
          'savingStatus',
          SavingStatus.failure,
        ),
      ],
    );
  });
}

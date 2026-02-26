import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:montebit/core/domain/entities/response.dart';
import 'package:montebit/core/domain/enums/fetching_status.dart';
import 'package:montebit/features/login/domain/entities/login_entity.dart';
import 'package:montebit/features/login/domain/entities/login_response_entity.dart';
import 'package:montebit/features/login/domain/failures/login_failures.dart';
import 'package:montebit/features/login/domain/repositories/login_repository.dart';
import 'package:montebit/features/login/ui/bloc/login_bloc.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

class FakeLoginEntity extends Fake implements LoginEntity {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeLoginEntity());
  });

  late LoginBloc loginBloc;
  late MockLoginRepository mockRepository;

  setUp(() {
    mockRepository = MockLoginRepository();
    loginBloc = LoginBloc(mockRepository);
  });

  tearDown(() {
    loginBloc.close();
  });

  test('initial state should be LoginState.initial()', () {
    expect(loginBloc.state.fetchingStatus, equals(FetchingStatus.initial));
  });

  group('ChangeEmailEvent', () {
    blocTest<LoginBloc, LoginState>(
      'emits updated email state on ChangeEmailEvent',
      build: () => loginBloc,
      act: (bloc) => bloc.add(ChangeEmailEvent('new@test.com')),
      expect: () => [
        isA<LoginState>().having((w) => w.login.email, 'email', 'new@test.com'),
      ],
    );
  });

  group('ChangePasswordEvent', () {
    blocTest<LoginBloc, LoginState>(
      'emits updated password state on ChangePasswordEvent',
      build: () => loginBloc,
      act: (bloc) => bloc.add(ChangePasswordEvent('newPass123')),
      expect: () => [
        isA<LoginState>().having(
          (w) => w.login.password,
          'password',
          'newPass123',
        ),
      ],
    );
  });

  group('DoLoginEvent', () {
    final tLoginEntity = LoginEntity(
      email: 'test@email.com',
      password: 'password123',
    );
    final tLoginResponseEntity = LoginResponseEntity(token: 'token123');

    blocTest<LoginBloc, LoginState>(
      'emits [loading, success] states on successful login',
      build: () {
        when(() => mockRepository.login(any())).thenAnswer(
          (_) async =>
              Response<LoginResponseEntity>.success(tLoginResponseEntity),
        );
        return loginBloc;
      },
      seed: () => LoginState.initial().copyWith(login: tLoginEntity),
      act: (bloc) => bloc.add(DoLoginEvent()),
      expect: () => [
        isA<LoginState>().having(
          (s) => s.fetchingStatus,
          'fetchingStatus',
          FetchingStatus.loading,
        ),
        isA<LoginState>().having(
          (s) => s.fetchingStatus,
          'fetchingStatus',
          FetchingStatus.success,
        ),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [loading, failure] states on failed login',
      build: () {
        when(() => mockRepository.login(any())).thenAnswer(
          (_) async =>
              Response<LoginResponseEntity>.failed(InvalidCredentialsFailure()),
        );
        return loginBloc;
      },
      seed: () => LoginState.initial().copyWith(login: tLoginEntity),
      act: (bloc) => bloc.add(DoLoginEvent()),
      expect: () => [
        isA<LoginState>().having(
          (s) => s.fetchingStatus,
          'fetchingStatus',
          FetchingStatus.loading,
        ),
        isA<LoginState>()
            .having(
              (s) => s.fetchingStatus,
              'fetchingStatus',
              FetchingStatus.failure,
            )
            .having(
              (s) => s.failure,
              'failure',
              isA<InvalidCredentialsFailure>(),
            ),
      ],
    );
  });
}

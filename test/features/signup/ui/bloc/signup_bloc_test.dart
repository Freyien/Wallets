import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:montebit/core/domain/entities/response.dart';
import 'package:montebit/core/domain/enums/saving_status.dart';
import 'package:montebit/features/signup/domain/entities/signup_entity.dart';
import 'package:montebit/features/signup/domain/entities/signup_response_entity.dart';
import 'package:montebit/features/signup/domain/failures/signup_failures.dart';
import 'package:montebit/features/signup/domain/repositories/signup_repository.dart';
import 'package:montebit/features/signup/ui/bloc/signup_bloc.dart';

class MockSignupRepository extends Mock implements SignupRepository {}

class FakeSignupEntity extends Fake implements SignupEntity {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeSignupEntity());
  });

  late SignupBloc signupBloc;
  late MockSignupRepository mockRepository;

  setUp(() {
    mockRepository = MockSignupRepository();
    signupBloc = SignupBloc(mockRepository);
  });

  tearDown(() {
    signupBloc.close();
  });

  test('initial state should be SignupState.initial()', () {
    expect(signupBloc.state.savingStatus, equals(SavingStatus.initial));
  });

  group('SignupEvent instantiation', () {
    test('supports instantiation and triggers constructors', () {
      expect(DoSignupEvent(), isA<DoSignupEvent>());
      expect(ChangeNickNameEvent('test').nickname, equals('test'));
      expect(ChangeEmailEvent('test').email, equals('test'));
      expect(ChangePhoneEvent('123').phone, equals('123'));
      expect(ChangePasswordEvent('pass').password, equals('pass'));
      expect(
        ChangeConfirmPasswordEvent('pass').confirmPassword,
        equals('pass'),
      );
    });
  });

  group('Input Events', () {
    blocTest<SignupBloc, SignupState>(
      'emits updated fullname state on ChangeNickNameEvent',
      build: () => signupBloc,
      act: (bloc) => bloc.add(ChangeNickNameEvent('Test User')),
      expect: () => [
        isA<SignupState>().having(
          (w) => w.signup.fullname,
          'fullname',
          'Test User',
        ),
      ],
    );

    blocTest<SignupBloc, SignupState>(
      'emits updated email state on ChangeEmailEvent',
      build: () => signupBloc,
      act: (bloc) => bloc.add(ChangeEmailEvent('new@test.com')),
      expect: () => [
        isA<SignupState>().having(
          (w) => w.signup.email,
          'email',
          'new@test.com',
        ),
      ],
    );

    blocTest<SignupBloc, SignupState>(
      'emits updated phone state on ChangePhoneEvent',
      build: () => signupBloc,
      act: (bloc) => bloc.add(ChangePhoneEvent('1234567890')),
      expect: () => [
        isA<SignupState>().having((w) => w.signup.phone, 'phone', '1234567890'),
      ],
    );

    blocTest<SignupBloc, SignupState>(
      'emits updated password state on ChangePasswordEvent',
      build: () => signupBloc,
      act: (bloc) => bloc.add(ChangePasswordEvent('newPass123')),
      expect: () => [
        isA<SignupState>().having(
          (w) => w.signup.password,
          'password',
          'newPass123',
        ),
      ],
    );

    blocTest<SignupBloc, SignupState>(
      'emits updated confirm password state on ChangeConfirmPasswordEvent',
      build: () => signupBloc,
      act: (bloc) => bloc.add(ChangeConfirmPasswordEvent('newPass123')),
      expect: () => [
        isA<SignupState>().having(
          (w) => w.signup.confirmPassword,
          'confirmPassword',
          'newPass123',
        ),
      ],
    );
  });

  group('DoSignupEvent', () {
    final tSignupEntity = SignupEntity(
      fullname: 'Test User',
      email: 'test@email.com',
      dialCode: '+52',
      phone: '1234567890',
      password: 'password123',
      confirmPassword: 'password123',
    );
    final tSignupResponseEntity = SignUpResponseEntity(token: 'token123');

    blocTest<SignupBloc, SignupState>(
      'emits [loading, success] states on successful registration',
      build: () {
        when(() => mockRepository.signUp(any())).thenAnswer(
          (_) async =>
              Response<SignUpResponseEntity>.success(tSignupResponseEntity),
        );
        return signupBloc;
      },
      seed: () => SignupState.initial().copyWith(signup: tSignupEntity),
      act: (bloc) => bloc.add(DoSignupEvent()),
      expect: () => [
        isA<SignupState>().having(
          (s) => s.savingStatus,
          'savingStatus',
          SavingStatus.loading,
        ),
        isA<SignupState>().having(
          (s) => s.savingStatus,
          'savingStatus',
          SavingStatus.success,
        ),
      ],
    );

    blocTest<SignupBloc, SignupState>(
      'emits [loading, failure] states on failed registration',
      build: () {
        when(() => mockRepository.signUp(any())).thenAnswer(
          (_) async => Response<SignUpResponseEntity>.failed(
            EmailOrPhoneAlreadyInUseFailure(),
          ),
        );
        return signupBloc;
      },
      seed: () => SignupState.initial().copyWith(signup: tSignupEntity),
      act: (bloc) => bloc.add(DoSignupEvent()),
      expect: () => [
        isA<SignupState>().having(
          (s) => s.savingStatus,
          'savingStatus',
          SavingStatus.loading,
        ),
        isA<SignupState>()
            .having((s) => s.savingStatus, 'savingStatus', SavingStatus.failure)
            .having(
              (s) => s.failure,
              'failure',
              isA<EmailOrPhoneAlreadyInUseFailure>(),
            ),
      ],
    );
  });
}

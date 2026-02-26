import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:montebit/core/domain/entities/response.dart';
import 'package:montebit/core/domain/enums/fetching_status.dart';
import 'package:montebit/core/domain/failures/failure.dart';
import 'package:montebit/features/profile/domain/entities/profile_entity.dart';
import 'package:montebit/features/profile/domain/repositories/profile_repository.dart';
import 'package:montebit/features/profile/ui/bloc/profile_bloc.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late ProfileBloc profileBloc;
  late MockProfileRepository mockRepository;

  setUp(() {
    mockRepository = MockProfileRepository();
    profileBloc = ProfileBloc(mockRepository);
  });

  tearDown(() {
    profileBloc.close();
  });

  const tProfileEntity = ProfileEntity(
    id: '1',
    fullName: 'Test User',
    email: 'test@test.com',
    phone: '1234567890',
    imageUrl: 'https://example.com/image.png',
  );

  test('initial state should be ProfileState.initial()', () {
    expect(profileBloc.state.fetchingStatus, equals(FetchingStatus.initial));
    expect(profileBloc.state.profile, equals(ProfileEntity.initial()));
  });

  group('ProfileState', () {
    test('copyWith should update the correct fields and preserve others', () {
      final initial = ProfileState.initial();
      final updated = initial.copyWith(
        fetchingStatus: FetchingStatus.success,
        profile: tProfileEntity,
      );

      expect(updated.fetchingStatus, equals(FetchingStatus.success));
      expect(updated.profile, equals(tProfileEntity));

      // Also confirm properties are retained when absent
      final partialUpdate = updated.copyWith(
        fetchingStatus: FetchingStatus.loading,
      );
      expect(partialUpdate.fetchingStatus, equals(FetchingStatus.loading));
      expect(partialUpdate.profile, equals(tProfileEntity));

      final partialUpdate2 = updated.copyWith();
      expect(partialUpdate2.fetchingStatus, equals(FetchingStatus.success));
      expect(partialUpdate2.profile, equals(tProfileEntity));
    });
  });

  group('GetProfileEvent', () {
    blocTest<ProfileBloc, ProfileState>(
      'emits [loading, success] states with profile data on successful fetch',
      build: () {
        when(() => mockRepository.getProfile()).thenAnswer(
          (_) async => Response<ProfileEntity>.success(tProfileEntity),
        );
        return profileBloc;
      },
      act: (bloc) => bloc.add(GetProfileEvent()),
      expect: () => [
        isA<ProfileState>().having(
          (s) => s.fetchingStatus,
          'fetchingStatus',
          FetchingStatus.loading,
        ),
        isA<ProfileState>()
            .having(
              (s) => s.fetchingStatus,
              'fetchingStatus',
              FetchingStatus.success,
            )
            .having((s) => s.profile, 'profile', equals(tProfileEntity)),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [loading, failure] states on failed fetch',
      build: () {
        when(() => mockRepository.getProfile()).thenAnswer(
          (_) async => Response<ProfileEntity>.failed(UnexpectedFailure()),
        );
        return profileBloc;
      },
      act: (bloc) => bloc.add(GetProfileEvent()),
      expect: () => [
        isA<ProfileState>().having(
          (s) => s.fetchingStatus,
          'fetchingStatus',
          FetchingStatus.loading,
        ),
        isA<ProfileState>().having(
          (s) => s.fetchingStatus,
          'fetchingStatus',
          FetchingStatus.failure,
        ),
      ],
    );
  });
}

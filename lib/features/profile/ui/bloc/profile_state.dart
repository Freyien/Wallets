part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    required this.fetchingStatus,
    required this.profile,
  });

  final FetchingStatus fetchingStatus;
  final ProfileEntity profile;

  factory ProfileState.initial() => ProfileState(
    fetchingStatus: FetchingStatus.initial,
    profile: ProfileEntity.initial(),
  );

  ProfileState copyWith({
    FetchingStatus? fetchingStatus,
    ProfileEntity? profile,
  }) {
    return ProfileState(
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object> get props => [
    fetchingStatus,
    profile,
  ];
}

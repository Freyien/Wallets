
part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    required this.fetchingStatus,
    required this.savingStatus,
    required this.profile,
  });

  final FetchingStatus fetchingStatus;
  final SavingStatus savingStatus;
  final ProfileEntity profile;

  factory ProfileState.initial() => ProfileState(
        fetchingStatus: FetchingStatus.initial,
        savingStatus: SavingStatus.initial,
        profile: ProfileEntity.initial(),
      );


  ProfileState copyWith({
    FetchingStatus? fetchingStatus,
    SavingStatus? savingStatus,
    ProfileEntity? profile,
  }) {
    return ProfileState(
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      savingStatus: savingStatus ?? this.savingStatus,
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object> get props => [fetchingStatus, savingStatus, profile,];
}


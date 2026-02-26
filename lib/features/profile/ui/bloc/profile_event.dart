part of 'profile_bloc.dart';

sealed class ProfileEvent {
  ProfileEvent();
}

class GetProfileEvent extends ProfileEvent {}


import 'package:bloc/bloc.dart';
import 'package:montebit/core/domain/enums/fetching_status.dart';
import 'package:montebit/core/domain/enums/saving_status.dart';
import 'package:montebit/features/profile/domain/entities/profile_entity.dart';
import 'package:montebit/features/profile/domain/repositories/profile_repository.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;

  ProfileBloc(this._repository) : super(ProfileState.initial()) {
    on<GetProfileEvent>(_onGetProfileEvent);
  }

  Future<void> _onGetProfileEvent(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(fetchingStatus: FetchingStatus.loading));

    final result = await _repository.getProfile();

    if (result.isSuccess) {
      return emit(state.copyWith(
        fetchingStatus: FetchingStatus.success,
        profile: result.data,
      ));
    }

    emit(state.copyWith(fetchingStatus: FetchingStatus.failure));
  }
}

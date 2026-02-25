import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/core/domain/enums/fetching_status.dart';
import 'package:montebit/core/ui/widgets/core_widgets.dart';
import 'package:montebit/features/profile/ui/bloc/profile_bloc.dart';

class ProfileFetchingBuilder extends StatelessWidget {
  const ProfileFetchingBuilder({super.key, required this.builder});

  final Widget Function(BuildContext, ProfileState) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (p, c) => p.fetchingStatus != c.fetchingStatus,
      builder: (context, state) {
        // Initial or Loading
        if (state.fetchingStatus.isInitialOrLoading) {
          return Loading();
        }

        // Failure
        if (state.fetchingStatus.isFailure) {
          return ErrorFullScreen(
            onAction: () {
              context.read<ProfileBloc>().add(GetProfileEvent());
            },
          );
        }

        // Success
        return builder(context, state);
      },
    );
  }
}

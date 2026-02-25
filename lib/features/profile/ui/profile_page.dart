import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/di/injection_modules.dart';
import 'package:montebit/features/profile/ui/bloc/profile_bloc.dart';
import 'package:montebit/features/profile/ui/widgets/profile_card_item.dart';
import 'package:montebit/features/profile/ui/widgets/profile_fetching_builder.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static String route = '/profile';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileBloc>()..add(GetProfileEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Perfil')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ProfileFetchingBuilder(
              builder: (context, state) {
                final profile = state.profile;

                return FadeInUp(
                  from: 10,
                  child: ProfileCardItem(profile: profile),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

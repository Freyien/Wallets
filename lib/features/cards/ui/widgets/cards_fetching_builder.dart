import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/core/domain/enums/fetching_status.dart';
import 'package:montebit/core/ui/widgets/core_widgets.dart';
import 'package:montebit/features/cards/ui/bloc/cards_bloc.dart';

class CardsFetchingBuilder extends StatelessWidget {
  const CardsFetchingBuilder({super.key, required this.builder});

  final Widget Function(BuildContext, CardsState) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardsBloc, CardsState>(
      buildWhen: (p, c) => p.fetchingStatus != c.fetchingStatus,
      builder: (context, state) {
        // Loading
        if (state.fetchingStatus.isInitialOrLoading) {
          return Loading();
        }

        // Failure
        if (state.fetchingStatus.isFailure) {
          return ErrorFullScreen(
            onAction: () {
              context.read<CardsBloc>().add(GetCardsEvent());
            },
          );
        }

        // Empty
        if (state.cards.isEmpty) {
          return ErrorFullScreen(
            title: 'Aun no hay tarjetas generadas.',
            message: 'Genera una nueva tarjeta para que aparezca aquí.',
            textButton: 'Agregar tarjeta',
            onAction: () {},
          );
        }

        // Success
        return builder(context, state);
      },
    );
  }
}

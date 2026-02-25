import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:montebit/core/domain/enums/saving_status.dart';
import 'package:montebit/features/add_card/ui/bloc/add_card_bloc.dart';
import 'package:montebit/features/cards/ui/bloc/cards_bloc.dart';

class AddCardSavingListener extends StatelessWidget {
  const AddCardSavingListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCardBloc, AddCardState>(
      listenWhen: (p, c) => p.savingStatus != c.savingStatus,
      listener: (context, state) {
        if (state.savingStatus.isSuccess) {
          context.read<CardsBloc>().add(GetCardsEvent());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tarjeta agregada'),
              backgroundColor: Colors.green,
            ),
          );
          context.pop();
          return;
        }

        if (state.savingStatus.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ocurrió un error al agregar tu tarjeta'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: child,
    );
  }
}

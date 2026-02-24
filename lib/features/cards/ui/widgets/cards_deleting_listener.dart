import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/core/domain/enums/deleting_status.dart';
import 'package:montebit/features/cards/ui/bloc/cards_bloc.dart';

class CardsDeletingListener extends StatelessWidget {
  const CardsDeletingListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CardsBloc, CardsState>(
      listenWhen: (previous, current) =>
          previous.deletingStatus != current.deletingStatus,
      listener: (context, state) {
        if (state.deletingStatus == DeletingStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tarjeta eliminada'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state.deletingStatus == DeletingStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ocurrió un error al eliminar tu tarjeta'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: child,
    );
  }
}

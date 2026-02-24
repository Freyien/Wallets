import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:montebit/core/domain/enums/fetching_status.dart';
import 'package:montebit/core/ui/widgets/vertical_space.dart';
import 'package:montebit/di/injection_modules.dart';
import 'package:montebit/features/add_card/ui/add_card_page.dart';
import 'package:montebit/features/cards/ui/bloc/cards_bloc.dart';
import 'package:montebit/features/cards/ui/widgets/card_item.dart';
import 'package:montebit/features/cards/ui/widgets/cards_fetching_builder.dart';
import 'package:montebit/features/login/ui/login_page.dart';
import 'package:montebit/features/logout/ui/bloc/logout_bloc.dart';
import 'package:montebit/features/logout/ui/bloc/logout_event.dart';
import 'package:montebit/features/logout/ui/bloc/logout_state.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  static const String route = '/cards';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CardsBloc>()..add(GetCardsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mis tarjetas'),
          actions: [
            IconButton(icon: CircleAvatar(radius: 18), onPressed: () {}),
          ],
        ),
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.85,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(radius: 25),
                  ),
                  Divider(height: 24),

                  ListTile(
                    title: Text(
                      'Inicio',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.1,
                      ),
                    ),
                    onTap: () {},
                    tileColor: Color(0xffDCE7C7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  VerticalSpace.xxsmall(),
                  ListTile(
                    title: Text(
                      'Agregar tarjeta',
                      style: TextStyle(letterSpacing: 0.1),
                    ),
                    onTap: () {
                      context.push(AddCardPage.route);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  VerticalSpace.xxsmall(),
                  ListTile(
                    title: Text('Perfil', style: TextStyle(letterSpacing: 0.1)),
                    onTap: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  Spacer(),
                  BlocProvider(
                    create: (context) => sl<LogoutBloc>(),
                    child: BlocConsumer<LogoutBloc, LogoutState>(
                      listenWhen: (previous, current) =>
                          previous.logoutStatus != current.logoutStatus,
                      listener: (context, state) {
                        if (state.logoutStatus == FetchingStatus.success) {
                          context.go(LoginPage.route);
                        }
                      },
                      builder: (context, state) {
                        final isLoading =
                            state.logoutStatus == FetchingStatus.loading;
                        return ListTile(
                          title: Row(
                            children: [
                              const Text(
                                'Cerrar sesión',
                                style: TextStyle(letterSpacing: 0.1),
                              ),
                              if (isLoading) ...[
                                const SizedBox(width: 16),
                                const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          onTap: isLoading
                              ? null
                              : () {
                                  context.read<LogoutBloc>().add(
                                    PerformLogoutEvent(),
                                  );
                                },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.push(AddCardPage.route);
          },
          label: Text('Agregar tarjeta'),
          icon: Icon(Icons.add),
        ),
        body: SafeArea(
          bottom: false,
          child: CardsFetchingBuilder(
            builder: (context, state) {
              final cards = state.cards;

              return ListView.separated(
                padding: EdgeInsets.all(16),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final card = cards[index];

                  return CardItem(card: card);
                },
                separatorBuilder: (context, index) {
                  return VerticalSpace.xxlarge();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

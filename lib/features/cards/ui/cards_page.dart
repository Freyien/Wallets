import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:montebit/core/ui/widgets/avatar_image.dart';
import 'package:montebit/features/cards/ui/bloc/cards_bloc.dart';
import 'package:montebit/features/cards/ui/widgets/cards_add_card_button.dart';
import 'package:montebit/features/cards/ui/widgets/cards_deleting_listener.dart';
import 'package:montebit/features/cards/ui/widgets/cards_drawer.dart';
import 'package:montebit/features/cards/ui/widgets/cards_fetching_builder.dart';
import 'package:montebit/features/cards/ui/widgets/cards_list.dart';
import 'package:montebit/features/profile/ui/profile_page.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  static const String route = '/cards';

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  @override
  void initState() {
    super.initState();
    context.read<CardsBloc>().add(GetCardsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis tarjetas'),
        actions: [
          IconButton(
            icon: AvatarImage(radius: 18),
            onPressed: () {
              context.push(ProfilePage.route);
            },
          ),
        ],
      ),
      // Drawer
      drawer: CardsDrawer(),
      // Floating button
      floatingActionButton: AddCardButton(),
      body: SafeArea(
        bottom: false,
        // Deleting listener
        child: CardsDeletingListener(
          child: CardsFetchingBuilder(
            builder: (context, state) {
              // Cards list
              return FadeInUp(
                from: 20,
                child: CardsList(cards: state.cards),
              );
            },
          ),
        ),
      ),
    );
  }
}

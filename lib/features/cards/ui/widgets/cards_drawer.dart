import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:montebit/core/ui/widgets/avatar_image.dart';
import 'package:montebit/core/ui/widgets/vertical_space.dart';
import 'package:montebit/di/injection_modules.dart';
import 'package:montebit/features/add_card/ui/add_card_page.dart';
import 'package:montebit/features/cards/ui/widgets/cards_drawer_item.dart';
import 'package:montebit/features/logout/ui/bloc/logout_bloc.dart';
import 'package:montebit/features/logout/ui/bloc/logout_event.dart';
import 'package:montebit/features/logout/ui/widgets/logout_listener.dart';
import 'package:montebit/features/profile/ui/profile_page.dart';

class CardsDrawer extends StatelessWidget {
  const CardsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LogoutBloc>(),
      child: LogoutListener(
        child: Drawer(
          width: MediaQuery.of(context).size.width * 0.85,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // Avatar
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        context.pop();
                        context.push(ProfilePage.route);
                      },
                      child: AvatarImage(radius: 25),
                    ),
                  ),
                  Divider(height: 24),

                  // Inicio
                  CardsDrawerItem(
                    title: 'Inicio',
                    onTap: () {
                      context.pop();
                    },
                    isSelected: true,
                  ),
                  VerticalSpace.xxsmall(),

                  // Agregar tarjeta
                  CardsDrawerItem(
                    title: 'Agregar tarjeta',
                    onTap: () {
                      context.pop();
                      context.push(AddCardPage.route);
                    },
                    isSelected: false,
                  ),
                  VerticalSpace.xxsmall(),

                  // Perfil
                  CardsDrawerItem(
                    title: 'Perfil',
                    onTap: () {
                      context.pop();
                      context.push(ProfilePage.route);
                    },
                    isSelected: false,
                  ),
                  Spacer(),

                  // Cerrar sesión
                  Builder(
                    builder: (context) {
                      return CardsDrawerItem(
                        title: 'Cerrar sesión',
                        onTap: () {
                          context.pop();
                          context.read<LogoutBloc>().add(PerformLogoutEvent());
                        },
                        isSelected: false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

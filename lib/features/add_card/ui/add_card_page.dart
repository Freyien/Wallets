import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/core/ui/widgets/vertical_space.dart';
import 'package:montebit/di/injection_modules.dart';
import 'package:montebit/features/add_card/ui/bloc/add_card_bloc.dart';
import 'package:montebit/features/add_card/ui/widgets/add_card_code_input.dart';
import 'package:montebit/features/add_card/ui/widgets/add_card_description_input.dart';
import 'package:montebit/features/add_card/ui/widgets/add_card_holder_input.dart';
import 'package:montebit/features/add_card/ui/widgets/add_card_number_input.dart';
import 'package:montebit/features/add_card/ui/widgets/add_card_preview.dart';
import 'package:montebit/features/add_card/ui/widgets/add_card_validity_input.dart';

class AddCardPage extends StatelessWidget {
  const AddCardPage({super.key});

  static const String route = '/add_card';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddCardBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Agregar Tarjeta')),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Preview
                AddCardPreview(),
                VerticalSpace.xxxlarge(),

                // Description
                AddCardDescriptionInput(),
                VerticalSpace.large(),

                // Number
                AddCardNumberInput(),
                VerticalSpace.large(),

                // Holder
                AddCardHolderInput(),
                VerticalSpace.large(),

                Row(
                  children: [
                    Expanded(flex: 4, child: AddCardValidityInput()),
                    SizedBox(width: 16),

                    Expanded(flex: 2, child: AddCardCodeInput()),
                  ],
                ),

                VerticalSpace.xxxlarge(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

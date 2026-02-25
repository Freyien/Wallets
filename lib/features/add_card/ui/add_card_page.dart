import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montebit/core/ui/widgets/core_widgets.dart';
import 'package:montebit/di/injection_modules.dart';
import 'package:montebit/features/add_card/ui/bloc/add_card_bloc.dart';
import 'package:montebit/features/add_card/ui/widgets/add_card_cancel_button.dart';
import 'package:montebit/features/add_card/ui/widgets/add_card_code_input.dart';
import 'package:montebit/features/add_card/ui/widgets/add_card_description_input.dart';
import 'package:montebit/features/add_card/ui/widgets/add_card_holder_input.dart';
import 'package:montebit/features/add_card/ui/widgets/add_card_number_input.dart';
import 'package:montebit/features/add_card/ui/widgets/add_card_preview.dart';
import 'package:montebit/features/add_card/ui/widgets/add_card_saving_listener.dart';
import 'package:montebit/features/add_card/ui/widgets/add_card_submit_button.dart';
import 'package:montebit/features/add_card/ui/widgets/add_card_validity_input.dart';
import 'package:montebit/features/add_card/ui/widgets/card_type_selector.dart';

class AddCardPage extends StatelessWidget {
  const AddCardPage({super.key});

  static const String route = '/add_card';

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => sl<AddCardBloc>(),
      child: AddCardSavingListener(
        child: Scaffold(
          appBar: AppBar(title: const Text('Agregar Tarjeta')),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: FadeInUp(
                  from: 10,
                  delay: Duration(milliseconds: 300),
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

                      // Card Type
                      const CardTypeSelector(),
                      VerticalSpace.large(),

                      // Holder
                      AddCardHolderInput(),
                      VerticalSpace.large(),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 4, child: AddCardValidityInput()),
                          SizedBox(width: 16),

                          Expanded(flex: 2, child: AddCardCodeInput()),
                        ],
                      ),

                      VerticalSpace.xxxlarge(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Cancel button
                          AddCardCancelButton(),

                          // Submit button
                          AddCardSubmitButton(formKey: formKey),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

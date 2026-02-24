import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montebit/core/ui/widgets/core_widgets.dart';
import 'package:montebit/features/cards/domain/entities/card_entity.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.card});

  final CardEntity card;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        color: Color(0xff00d394).withAlpha(77),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xffC5C8B9), width: 1),
      ),
      child: Column(
        children: [
          // Delete button
          _DeleteButton(),
          VerticalSpace.xxxlarge(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Description
              _CardDescription(description: card.description),

              // Processor logo
              _ProcessorLogo(cardTypeProcessor: card.cardTypeProcessor),
            ],
          ),
          VerticalSpace.small(),

          // Card number
          _CardNumber(card: card),
          VerticalSpace.small(),

          // Card holder and validity
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Card holder
              Text(card.cardHolder),

              // Validity
              Text(card.validity),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardNumber extends StatelessWidget {
  const _CardNumber({super.key, required this.card});

  final CardEntity card;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(3, (index) {
          return Text('●●●● ', style: TextStyle(fontSize: 16));
        }),
        Text(card.last4Digits, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        style: IconButton.styleFrom(
          side: BorderSide(color: Color(0xff75786C), width: 1),
        ),
        onPressed: () {},
        icon: SvgPicture.asset('assets/svg/delete_icon.svg'),
      ),
    );
  }
}

class _CardDescription extends StatelessWidget {
  const _CardDescription({required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );
  }
}

class _ProcessorLogo extends StatelessWidget {
  const _ProcessorLogo({required this.cardTypeProcessor});

  String getProcessorLogo() {
    switch (cardTypeProcessor) {
      case 'amex':
        return 'assets/svg/amex.svg';
      case 'visa':
        return 'assets/svg/visa.svg';
      case 'mastercard':
        return 'assets/svg/mastercard.svg';
      default:
        return '';
    }
  }

  final String cardTypeProcessor;

  @override
  Widget build(BuildContext context) {
    final processorLogo = getProcessorLogo();

    return processorLogo.isNotEmpty
        ? SvgPicture.asset(processorLogo)
        : SizedBox.shrink();
  }
}

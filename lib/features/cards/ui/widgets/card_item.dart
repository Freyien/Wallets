import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montebit/core/domain/entities/card_entity.dart';
import 'package:montebit/core/ui/widgets/core_widgets.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.card, this.showDeleteButton = true});

  final CardEntity card;
  final bool showDeleteButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        color: card.cardTypeProcessor.backgroundColor.withAlpha(77),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xffC5C8B9), width: 1),
      ),
      child: Column(
        children: [
          // Delete button
          showDeleteButton ? _DeleteButton() : SizedBox.shrink(),
          showDeleteButton ? VerticalSpace.xxxlarge() : SizedBox.shrink(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Description
              _CardDescription(description: card.description),

              // Processor logo
              _ProcessorLogo(processorType: card.cardTypeProcessor),
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
  const _CardNumber({required this.card});

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
  const _ProcessorLogo({required this.processorType});

  final ProcessorType processorType;

  @override
  Widget build(BuildContext context) {
    final logoPath = processorType.logoPath;

    return logoPath.isNotEmpty
        ? SvgPicture.asset(logoPath)
        : const SizedBox.shrink();
  }
}

extension ProcessorTypeExtension on ProcessorType {
  Color get backgroundColor {
    switch (this) {
      case ProcessorType.amex:
        return const Color(0xff00D394);
      case ProcessorType.mastercard:
        return const Color(0xff151515);
      case ProcessorType.visa:
        return const Color(0xff6B00D6);
      case ProcessorType.unknown:
        return const Color(0xff00d394).withAlpha(77);
    }
  }

  String get logoPath {
    switch (this) {
      case ProcessorType.amex:
        return 'assets/svg/amex.svg';
      case ProcessorType.visa:
        return 'assets/svg/visa.svg';
      case ProcessorType.mastercard:
        return 'assets/svg/mastercard.svg';
      case ProcessorType.unknown:
        return '';
    }
  }
}

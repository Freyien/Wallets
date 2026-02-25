import 'package:equatable/equatable.dart';

class CardEntity extends Equatable {
  final String? id;
  final CardType card;
  final String number;
  final ProcessorType processor;
  final String holder;
  final String description;
  final String validity;
  final String code;

  const CardEntity({
    this.id,
    required this.card,
    required this.number,
    required this.processor,
    required this.holder,
    required this.description,
    required this.validity,
    required this.code,
  });

  factory CardEntity.initial() => const CardEntity(
    card: CardType.credit,
    number: '',
    processor: ProcessorType.unknown,
    holder: '',
    description: '',
    validity: '',
    code: '',
  );

  factory CardEntity.fromJson(Map<String, dynamic> json) {
    final lastFourDigits = json['last_four_digits'] as String? ?? '';
    final cardNumber = '**** **** **** $lastFourDigits';

    return CardEntity(
      id: json['id'] as String,
      card: CardType.fromString(json['type'] as String? ?? ''),
      number: cardNumber,
      processor: ProcessorType.fromString(json['processor'] as String? ?? ''),
      holder: json['card_holder'] as String? ?? '',
      description: json['description'] as String? ?? '',
      validity: json['expiration_date'] as String? ?? '',
      code: json['code'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'cardType': card.name,
      'cardNumber': number,
      'cardTypeProcessor': calculateProcessor.name.toUpperCase(),
      'cardHolder': holder,
      'description': description,
      'validity': validity,
      'code': code,
    };
  }

  String get last4Digits =>
      number.length >= 4 ? number.substring(number.length - 4) : number;

  String get formattedValidity {
    if (validity.contains('/') && validity.split('/')[1].length == 4) {
      final parts = validity.split('/');
      return '${parts[0]}/${parts[1].substring(2)}';
    }
    return validity;
  }

  ProcessorType get calculateProcessor {
    if (processor != ProcessorType.unknown) {
      return processor;
    }

    final cleanNumber = number.replaceAll(' ', '');
    if (cleanNumber.isEmpty) return ProcessorType.unknown;

    if (cleanNumber.startsWith('4')) {
      return ProcessorType.visa;
    } else if (cleanNumber.startsWith('5')) {
      return ProcessorType.mastercard;
    } else if (cleanNumber.startsWith('3')) {
      return ProcessorType.amex;
    }

    return ProcessorType.unknown;
  }

  CardEntity copyWith({
    String? id,
    CardType? type,
    String? number,
    ProcessorType? processor,
    String? holder,
    String? description,
    String? validity,
    String? code,
  }) {
    return CardEntity(
      id: id ?? this.id,
      card: type ?? card,
      number: number ?? this.number,
      processor: processor ?? this.processor,
      holder: holder ?? this.holder,
      description: description ?? this.description,
      validity: validity ?? this.validity,
      code: code ?? this.code,
    );
  }

  @override
  List<Object?> get props => [
    id,
    card,
    number,
    processor,
    holder,
    description,
    validity,
    code,
  ];
}

enum ProcessorType {
  amex,
  visa,
  mastercard,
  unknown;

  static ProcessorType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'amex':
        return ProcessorType.amex;
      case 'visa':
        return ProcessorType.visa;
      case 'mastercard':
        return ProcessorType.mastercard;
      default:
        return ProcessorType.unknown;
    }
  }
}

enum CardType {
  credit,
  debit,
  points,
  unknown;

  static CardType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'credit':
        return CardType.credit;
      case 'debit':
        return CardType.debit;
      case 'points':
        return CardType.points;
      default:
        return CardType.credit;
    }
  }
}

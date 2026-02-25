import 'package:equatable/equatable.dart';

class CardEntity extends Equatable {
  final int? id;
  final CardType cardType;
  final String cardNumber;
  final ProcessorType cardTypeProcessor;
  final String cardHolder;
  final String description;
  final String validity;
  final String code;
  final int? userId;

  const CardEntity({
    this.id,
    required this.cardType,
    required this.cardNumber,
    required this.cardTypeProcessor,
    required this.cardHolder,
    required this.description,
    required this.validity,
    required this.code,
    this.userId,
  });

  factory CardEntity.initial() => const CardEntity(
    cardType: CardType.credit,
    cardNumber: '',
    cardTypeProcessor: ProcessorType.unknown,
    cardHolder: '',
    description: '',
    validity: '',
    code: '',
  );

  factory CardEntity.fromJson(Map<String, dynamic> json) {
    return CardEntity(
      id: json['id'] as int?,
      cardType: CardType.fromString(json['cardType'] as String? ?? ''),
      cardNumber: json['cardNumber'] as String? ?? '',
      cardTypeProcessor: ProcessorType.fromString(
        json['cardTypeProcessor'] as String? ?? '',
      ),
      cardHolder: json['cardHolder'] as String? ?? '',
      description: json['description'] as String? ?? '',
      validity: json['validity'] as String? ?? '',
      code: json['code'] as String? ?? '',
      userId: json['userId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'cardType': cardType.name,
      'cardNumber': cardNumber,
      'cardTypeProcessor': cardTypeProcessor.name,
      'cardHolder': cardHolder,
      'description': description,
      'validity': validity,
      'code': code,
      if (userId != null) 'userId': userId,
    };
  }

  String get last4Digits => cardNumber.length >= 4
      ? cardNumber.substring(cardNumber.length - 4)
      : cardNumber;

  String get formattedValidity {
    if (validity.contains('/') && validity.split('/')[1].length == 4) {
      final parts = validity.split('/');
      return '${parts[0]}/${parts[1].substring(2)}';
    }
    return validity;
  }

  bool get isPointsCard => displayProcessorType == ProcessorType.unknown;

  ProcessorType get displayProcessorType {
    if (cardTypeProcessor != ProcessorType.unknown) {
      return cardTypeProcessor;
    }

    final cleanNumber = cardNumber.replaceAll(' ', '');
    if (cleanNumber.isEmpty) return ProcessorType.unknown;

    if (cleanNumber.startsWith(RegExp(r'^4'))) {
      return ProcessorType.visa;
    } else if (cleanNumber.startsWith(RegExp(r'^(5[1-5]|2[2-7])'))) {
      return ProcessorType.mastercard;
    } else if (cleanNumber.startsWith(RegExp(r'^3[47]'))) {
      return ProcessorType.amex;
    }

    return ProcessorType.unknown;
  }

  CardEntity copyWith({
    int? id,
    CardType? cardType,
    String? cardNumber,
    ProcessorType? cardTypeProcessor,
    String? cardHolder,
    String? description,
    String? validity,
    String? code,
    int? userId,
  }) {
    return CardEntity(
      id: id ?? this.id,
      cardType: cardType ?? this.cardType,
      cardNumber: cardNumber ?? this.cardNumber,
      cardTypeProcessor: cardTypeProcessor ?? this.cardTypeProcessor,
      cardHolder: cardHolder ?? this.cardHolder,
      description: description ?? this.description,
      validity: validity ?? this.validity,
      code: code ?? this.code,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [
    id,
    cardType,
    cardNumber,
    cardTypeProcessor,
    cardHolder,
    description,
    validity,
    code,
    userId,
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

import 'package:equatable/equatable.dart';

class CardEntity extends Equatable {
  final int? id;
  final String cardType;
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
    cardType: '',
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
      cardType: json['cardType'] as String? ?? '',
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
      'cardType': cardType,
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

  CardEntity copyWith({
    int? id,
    String? cardType,
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

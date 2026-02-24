import 'package:equatable/equatable.dart';

class CardEntity extends Equatable {
  final int id;
  final String cardType;
  final String cardNumber;
  final String cardTypeProcessor;
  final String cardHolder;
  final String description;
  final String validity;
  final String code;
  final int userId;

  const CardEntity({
    required this.id,
    required this.cardType,
    required this.cardNumber,
    required this.cardTypeProcessor,
    required this.cardHolder,
    required this.description,
    required this.validity,
    required this.code,
    required this.userId,
  });

  factory CardEntity.initial() => const CardEntity(
    id: 0,
    cardType: '',
    cardNumber: '',
    cardTypeProcessor: '',
    cardHolder: '',
    description: '',
    validity: '',
    code: '',
    userId: 0,
  );

  factory CardEntity.fromJson(Map<String, dynamic> json) {
    return CardEntity(
      id: json['id'] as int,
      cardType: json['cardType'] as String,
      cardNumber: json['cardNumber'] as String,
      cardTypeProcessor: json['cardTypeProcessor'] as String,
      cardHolder: json['cardHolder'] as String,
      description: json['description'] as String,
      validity: json['validity'] as String,
      code: json['code'] as String,
      userId: json['userId'] as int,
    );
  }

  String get last4Digits => cardNumber.substring(cardNumber.length - 4);

  CardEntity copyWith({
    int? id,
    String? cardType,
    String? cardNumber,
    String? cardTypeProcessor,
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
  List<Object> get props => [
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

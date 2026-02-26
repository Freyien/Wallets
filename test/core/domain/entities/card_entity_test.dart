import 'package:flutter_test/flutter_test.dart';
import 'package:montebit/core/domain/entities/card_entity.dart';

void main() {
  group('CardEntity', () {
    final tCardJson = {
      'id': '123',
      'type': 'CREDIT',
      'processor': 'VISA',
      'card_holder': 'Test User',
      'description': 'My Card',
      'expiration_date': '12/26',
      'code': '123',
      'last_four_digits': '5678',
    };

    final tCardEntity = CardEntity(
      id: '123',
      type: CardType.credit,
      number: '**** **** **** 5678',
      processor: ProcessorType.visa,
      holder: 'Test User',
      description: 'My Card',
      validity: '12/26',
      code: '123',
    );

    test('should return a valid model from JSON', () {
      final result = CardEntity.fromJson(tCardJson);
      expect(result, equals(tCardEntity));
    });

    test('should return a JSON map containing the proper data', () {
      final result = tCardEntity.toJson();
      final expectedJson = {
        'id': '123',
        'cardType': 'CREDIT',
        'cardNumber': '**** **** **** 5678',
        'cardTypeProcessor': 'VISA',
        'cardHolder': 'Test User',
        'description': 'My Card',
        'validity': '12/26',
        'code': '123',
      };
      expect(result, equals(expectedJson));
    });

    test('initial() should return an empty default CardEntity', () {
      final result = CardEntity.initial();
      expect(result.type, equals(CardType.credit));
      expect(result.number, equals(''));
      expect(result.processor, equals(ProcessorType.unknown));
      expect(result.holder, equals(''));
      expect(result.description, equals(''));
      expect(result.validity, equals(''));
      expect(result.code, equals(''));
    });

    test('copyWith should return a new updated CardEntity', () {
      final updated = tCardEntity.copyWith(description: 'Updated');
      expect(updated.description, equals('Updated'));
      expect(updated.id, equals('123')); // ensure others are unchanged
    });

    test('last4Digits should return the last 4 characters of the number', () {
      expect(tCardEntity.last4Digits, equals('5678'));
      final shortNumber = tCardEntity.copyWith(number: '123');
      expect(
        shortNumber.last4Digits,
        equals('123'),
      ); // Handles case where length < 4
    });

    test(
      'formattedValidity should properly format MM/YYYY string to MM/YY',
      () {
        final card = tCardEntity.copyWith(validity: '12/2026');
        expect(card.formattedValidity, equals('12/26'));
        expect(
          tCardEntity.formattedValidity,
          equals('12/26'),
        ); // Leave unmodified format intact
      },
    );

    group('calculateProcessor', () {
      test('should return current processor if it is not unknown', () {
        expect(tCardEntity.calculateProcessor, equals(ProcessorType.visa));
      });

      test('should return visa when number starts with 4', () {
        final card = CardEntity.initial().copyWith(number: '4123 4567');
        expect(card.calculateProcessor, equals(ProcessorType.visa));
      });

      test('should return mastercard when number starts with 5', () {
        final card = CardEntity.initial().copyWith(number: '5123');
        expect(card.calculateProcessor, equals(ProcessorType.mastercard));
      });

      test('should return amex when number starts with 3', () {
        final card = CardEntity.initial().copyWith(number: '3123');
        expect(card.calculateProcessor, equals(ProcessorType.amex));
      });

      test('should return unknown for empty number and unknown processor', () {
        final card = CardEntity.initial().copyWith(number: '');
        expect(card.calculateProcessor, equals(ProcessorType.unknown));
      });
    });

    test('ProcessorType.fromString should map correctly', () {
      expect(ProcessorType.fromString('amex'), equals(ProcessorType.amex));
      expect(ProcessorType.fromString('VISA'), equals(ProcessorType.visa));
      expect(
        ProcessorType.fromString('masterCard'),
        equals(ProcessorType.mastercard),
      );
      expect(
        ProcessorType.fromString('unknown'),
        equals(ProcessorType.unknown),
      );
    });

    test('CardType.fromString should map correctly', () {
      expect(CardType.fromString('credit'), equals(CardType.credit));
      expect(CardType.fromString('DeBiT'), equals(CardType.debit));
      expect(CardType.fromString('Points'), equals(CardType.points));
      expect(
        CardType.fromString('unknown'),
        equals(CardType.credit),
      ); // Default is credit
    });
  });
}

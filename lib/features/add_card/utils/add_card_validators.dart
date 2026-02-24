import 'package:montebit/core/domain/entities/card_entity.dart';

class AddCardValidators {
  static String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El alias de la tarjeta es requerido';
    }
    if (value.trim().length < 5) {
      return 'El alias debe tener al menos 5 caracteres';
    }
    if (value.trim().length > 20) {
      return 'El alias debe tener menos de 20 caracteres';
    }
    return null;
  }

  static String? validateCardNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El número de tarjeta es requerido';
    }
    final cleanValue = value.replaceAll(' ', '');
    if (cleanValue.length < 15) {
      return 'El número de tarjeta no es válido';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(cleanValue)) {
      return 'El número debe contener solo dígitos';
    }

    final dummyCard = CardEntity.initial().copyWith(cardNumber: cleanValue);
    if (dummyCard.displayProcessorType == ProcessorType.unknown) {
      return 'Solo tarjetas Visa, Mastercard o Amex';
    }

    return null;
  }

  static String? validateCardHolder(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El nombre del titular es requerido';
    }
    if (value.trim().length < 6) {
      return 'El nombre debe tener al menos 6 caracteres';
    }
    if (value.trim().length > 20) {
      return 'El nombre debe tener menos de 20 caracteres';
    }
    return null;
  }

  static String? validateValidity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo requerido';
    }

    if (!RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$').hasMatch(value)) {
      return 'El formato debe ser MM/YY';
    }

    final parts = value.split('/');
    if (parts.length != 2) return 'Formato inválido';

    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);

    if (month == null || year == null) return 'Formato inválido';

    final now = DateTime.now();
    final currentYear = now.year % 100; // Get last two digits of current year
    final currentMonth = now.month;

    if (year < currentYear) {
      return 'La tarjeta ha expirado';
    }

    if (year == currentYear && month < currentMonth) {
      return 'La tarjeta ha expirado';
    }

    return null;
  }

  static String? validateCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo requerido';
    }
    if (value.length < 3 || value.length > 4) {
      return 'El CVV debe tener 3 o 4 dígitos';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'El CVV debe contener solo dígitos';
    }
    return null;
  }
}

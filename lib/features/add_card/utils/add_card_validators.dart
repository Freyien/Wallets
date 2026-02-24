class AddCardValidators {
  static String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El alias de la tarjeta es requerido';
    }
    if (value.trim().length < 5) {
      return 'El alias debe tener al menos 5 caracteres';
    }
    return null;
  }

  static String? validateCardNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El número de tarjeta es requerido';
    }
    final cleanValue = value.replaceAll(' ', '');
    if (cleanValue.length == 16) {
      return 'El número de tarjeta no es válido';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(cleanValue)) {
      return 'El número debe contener solo dígitos';
    }
    return null;
  }

  static String? validateCardHolder(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El nombre del titular es requerido';
    }
    if (value.trim().length < 3) {
      return 'El nombre debe tener al menos 3 caracteres';
    }
    return null;
  }

  static String? validateValidity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'La fecha de expiración es requerida';
    }
    // Basic validation format MM/YY or MM/YYYY
    if (!RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2}|[0-9]{4})$').hasMatch(value)) {
      return 'El formato debe ser MM/YY';
    }
    return null;
  }

  static String? validateCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El CVV es requerido';
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

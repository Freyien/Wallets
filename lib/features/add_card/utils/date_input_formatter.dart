import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var newText = newValue.text;

    if (newText.length > oldValue.text.length) {
      if (newText.length == 2 && !newText.contains('/')) {
        newText += '/';
      } else if (newText.length == 3 && !newText.contains('/')) {
        newText = '${newText.substring(0, 2)}/${newText.substring(2)}';
      }
    }

    if (newText.length > 5) {
      newText = newText.substring(0, 5);
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

import 'package:flutter/services.dart';

class DecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final regExp = RegExp(r'^-?\d*$');

    final isNewValueValid = newValue.text.isEmpty || regExp.hasMatch(newValue.text);

    return isNewValueValid ? newValue : oldValue;
  }
}

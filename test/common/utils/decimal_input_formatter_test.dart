import 'package:flutter_test/flutter_test.dart';
import 'package:number_converter_app/common/utils/decimal_input_formatter.dart';

void main() {
  late DecimalInputFormatter formatter;

  setUp(() {
    formatter = DecimalInputFormatter();
  });

  test('should allow valid decimal input', () {
    const validInputs = [
      '0',
      '123',
      '-123',
      '7890',
    ];

    for (final input in validInputs) {
      const oldValue = TextEditingValue.empty;
      final newValue = TextEditingValue(text: input);

      expect(formatter.formatEditUpdate(oldValue, newValue), newValue);
    }
  });

  test('should disallow invalid decimal input', () {
    const invalidInputs = [
      'a',
      '12a',
      '-1a',
      '12.34',
      '-12.34',
    ];

    for (final input in invalidInputs) {
      const oldValue = TextEditingValue.empty;
      final newValue = TextEditingValue(text: input);

      expect(formatter.formatEditUpdate(oldValue, newValue), oldValue);
    }
  });
}

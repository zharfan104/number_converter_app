import 'package:flutter_test/flutter_test.dart';
import 'package:number_converter_app/common/utils/string_extension.dart';

void main() {
  group('StringExtension.capitalize', () {
    test('should capitalize the first letter and lowercase the rest', () {
      expect('hello'.capitalize(), 'Hello');
      expect('WORLD'.capitalize(), 'World');
      expect('DaRt LaNGuAge'.capitalize(), 'Dart language');
    });

    test('should not change the capitalization if it is already correct', () {
      expect('Testing'.capitalize(), 'Testing');
      expect('Flutter'.capitalize(), 'Flutter');
    });

    test('should return an empty string if the input is empty', () {
      expect(''.capitalize(), '');
    });

    test('should return the same string if it contains only one character', () {
      expect('a'.capitalize(), 'A');
      expect('Z'.capitalize(), 'Z');
    });

    test('should handle special characters correctly', () {
      expect(r'$dart'.capitalize(), r'$dart');
      expect('#1 language'.capitalize(), '#1 language');
      expect('😃emojis'.capitalize(), '😃emojis');
    });
  });
}

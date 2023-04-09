import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_converter_app/common/utils/text_widget_size_calculator.dart';

const _kTestTextWidth = 260.0;

void main() {
  group('TextWidgetSizeCalculator', () {
    test('computeTextWidth returns the correct width', () {
      const text = 'Hello, world!';
      const style = TextStyle(fontSize: 20);
      final actualWidth = TextWidgetSizeCalculator.computeTextWidth(text: text, style: style);
      expect(actualWidth, _kTestTextWidth);
    });

    test('computeTextHeight returns the correct height', () {
      const text = 'Hello, world!';
      const style = TextStyle(fontSize: 20);
      final actualHeight = TextWidgetSizeCalculator.computeTextHeight(
        text: text,
        style: style,
        maxWidth: _kTestTextWidth,
      );
      expect(actualHeight, 20);
    });
  });
}

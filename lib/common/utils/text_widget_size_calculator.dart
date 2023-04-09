import 'package:flutter/material.dart';

class TextWidgetSizeCalculator {
  static Size _computeTextSize({
    required String text,
    required TextStyle style,
    required double maxWidth,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: maxWidth);

    return textPainter.size;
  }

  static double computeTextWidth({
    required String text,
    required TextStyle style,
  }) {
    return _computeTextSize(text: text, style: style, maxWidth: double.infinity).width;
  }

  static double computeTextHeight({
    required String text,
    required TextStyle style,
    required double maxWidth,
  }) {
    return _computeTextSize(text: text, style: style, maxWidth: maxWidth).height;
  }
}

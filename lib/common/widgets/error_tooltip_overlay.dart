import 'dart:math';
import 'package:flutter/material.dart';

import '../ui/app_colors.dart';
import '../ui/app_size_constants.dart';
import '../utils/text_widget_size_calculator.dart';
import 'triangle_painter.dart';

const _kArrowWidth = 12.0;
const _kArrowHeight = 8.0;

const EdgeInsets _kTextPadding = EdgeInsets.all(kSpacingXSmall);

const double _kMinTooltipWidth = 50;
const double _kMaxTooltipWidthRatioFromScreenWidth = 0.8;

const double _kTooltipRightPadding = 12.0;

// Custom text style for easier computation of text sizes
const TextStyle _kTooltipTextStyle = TextStyle(color: Colors.white, fontSize: 16);

class ErrorTooltipOverlay extends StatelessWidget {
  const ErrorTooltipOverlay({
    super.key,
    required this.leftPosition,
    required this.topPosition,
    required this.tooltipWidth,
    required this.arrowLeftPosition,
    required this.message,
  });

  final double leftPosition;
  final double topPosition;
  final double tooltipWidth;
  final double arrowLeftPosition;
  final String message;

  static OverlayEntry createOverlayEntry(
    BuildContext context, {
    required String message,
    required GlobalKey iconKey,
  }) {
    final RenderBox iconBox = iconKey.currentContext!.findRenderObject()! as RenderBox;
    final iconPosition = iconBox.localToGlobal(Offset.zero);

    // Calculate the width of the text with the custom style
    final textWidth = TextWidgetSizeCalculator.computeTextWidth(
      text: message,
      style: _kTooltipTextStyle,
    );
    final double textWidthWithPadding = textWidth + _kTextPadding.horizontal;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double maxTooltipWidth = screenWidth * _kMaxTooltipWidthRatioFromScreenWidth;
    final double tooltipWidth = max(_kMinTooltipWidth, min(maxTooltipWidth, textWidthWithPadding));

    // Calculate the height of the text with the custom style and the given tooltip width
    final toolTipHeight = TextWidgetSizeCalculator.computeTextHeight(
      text: message,
      style: _kTooltipTextStyle,
      maxWidth: tooltipWidth,
    );

    // Calculate the left position for the tooltip and the arrow
    final rightBoundary = screenWidth - tooltipWidth;
    final leftPosition = iconPosition.dx > rightBoundary ? rightBoundary - _kTooltipRightPadding : iconPosition.dx;

    // Calculate the top position for the tooltip
    final topPosition = iconPosition.dy - toolTipHeight - _kArrowHeight;

    final iconBoxCenter = iconBox.size.width / 2;
    final arrowLeftPosition = iconPosition.dx - leftPosition - (_kArrowWidth / 2) + iconBoxCenter;

    return OverlayEntry(
      builder: (BuildContext context) {
        return ErrorTooltipOverlay(
          leftPosition: leftPosition,
          topPosition: topPosition,
          tooltipWidth: tooltipWidth,
          arrowLeftPosition: arrowLeftPosition,
          message: message,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: leftPosition,
      top: topPosition,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              width: tooltipWidth,
              padding: _kTextPadding,
              margin: const EdgeInsets.only(bottom: _kArrowHeight),
              decoration: BoxDecoration(
                color: AppColors.lightRed,
                borderRadius: BorderRadius.circular(kRadiusXSmall),
              ),
              child: Center(
                child: Text(
                  message,
                  style: _kTooltipTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: arrowLeftPosition,
              child: CustomPaint(
                painter: TrianglePainter(color: AppColors.lightRed),
                child: const SizedBox(
                  width: _kArrowWidth,
                  height: _kArrowHeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

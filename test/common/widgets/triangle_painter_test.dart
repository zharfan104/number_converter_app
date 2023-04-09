import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_converter_app/common/widgets/triangle_painter.dart';

void main() {
  group('TrianglePainter', () {
    testWidgets(
      'should not repaint when color is the same',
      (WidgetTester tester) async {
        const triangleColor = Colors.red;
        final trianglePainter = TrianglePainter(color: triangleColor);
        final oldTrianglePainter = TrianglePainter(color: triangleColor);

        expect(trianglePainter.shouldRepaint(oldTrianglePainter), false);
      },
    );

    testWidgets('should repaint when color is different', (WidgetTester tester) async {
      const triangleColor = Colors.red;
      const differentTriangleColor = Colors.blue;
      final trianglePainter = TrianglePainter(color: triangleColor);
      final oldTrianglePainter = TrianglePainter(color: differentTriangleColor);

      expect(trianglePainter.shouldRepaint(oldTrianglePainter), true);
    });
  });
}

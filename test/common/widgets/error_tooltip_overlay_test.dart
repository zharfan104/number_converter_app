import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_converter_app/common/widgets/error_tooltip_overlay.dart';

void main() {
  group(
    'ErrorTooltipOverlay Widget',
    () {
      testWidgets(
        'ErrorTooltipOverlay should display a short message with correct positioning',
        (WidgetTester tester) async {
          const message = 'Short Message';
          final GlobalKey iconKey = GlobalKey();

          // Mock the icon
          await tester.pumpWidget(
            MaterialApp(
              home: Builder(
                builder: (BuildContext context) {
                  return Scaffold(
                    body: Center(
                      child: GestureDetector(
                        child: Icon(Icons.info, key: iconKey),
                        onTap: () {
                          final overlayEntry = ErrorTooltipOverlay.createOverlayEntry(
                            context,
                            message: message,
                            iconKey: iconKey,
                          );
                          Overlay.of(context).insert(overlayEntry);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          );

          // Find the ErrorTooltipOverlay by its message
          final errorTooltipOverlayFinder = find.text(message);

          expect(errorTooltipOverlayFinder, findsNothing);

          await tester.tap(find.byType(Icon));
          await tester.pumpAndSettle();

          // Pump the widget
          await tester.pump();

          // Verify the tooltip is displayed
          expect(errorTooltipOverlayFinder, findsOneWidget);

          // Verify the tooltip's position
          final positionedTooltip = tester
              .widget<Positioned>(find.ancestor(of: errorTooltipOverlayFinder, matching: find.byType(Positioned)));
          expect(positionedTooltip.left, 388.0);
          expect(positionedTooltip.top, 264.0);

          // Verify the tooltip's message
          final tooltipText = tester.widget<Text>(errorTooltipOverlayFinder);
          expect(tooltipText.data, message);
        },
      );

      testWidgets(
        'ErrorTooltipOverlay should display a long message with correct positioning',
        (WidgetTester tester) async {
          const message =
              'Very Very Very Very Very Very Very Very Very Very Very Very Very Very Very Very Long Message';
          final GlobalKey iconKey = GlobalKey();

          // Mock the icon
          await tester.pumpWidget(
            MaterialApp(
              home: Builder(
                builder: (BuildContext context) {
                  return Scaffold(
                    body: Center(
                      child: GestureDetector(
                        child: Icon(Icons.info, key: iconKey),
                        onTap: () {
                          final overlayEntry = ErrorTooltipOverlay.createOverlayEntry(
                            context,
                            message: message,
                            iconKey: iconKey,
                          );
                          Overlay.of(context).insert(overlayEntry);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          );

          // Find the ErrorTooltipOverlay by its message
          final errorTooltipOverlayFinder = find.text(message);

          expect(errorTooltipOverlayFinder, findsNothing);

          await tester.tap(find.byType(Icon));
          await tester.pumpAndSettle();

          // Pump the widget
          await tester.pump();

          // Verify the tooltip is displayed
          expect(errorTooltipOverlayFinder, findsOneWidget);

          // Verify the tooltip's position
          final positionedTooltip = tester
              .widget<Positioned>(find.ancestor(of: errorTooltipOverlayFinder, matching: find.byType(Positioned)));
          expect(positionedTooltip.left, 148.0);
          expect(positionedTooltip.top, 232.0);

          // Verify the tooltip's message
          final tooltipText = tester.widget<Text>(errorTooltipOverlayFinder);
          expect(tooltipText.data, message);
        },
      );
    },
  );
}

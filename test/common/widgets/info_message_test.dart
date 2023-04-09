import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_converter_app/common/widgets/info_message.dart';

void main() {
  group('InfoMessage widget', () {
    const messageText = 'This is an info message';

    testWidgets('should displays the provided message text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoMessage(text: messageText),
          ),
        ),
      );

      final messageFinder = find.text(messageText);
      expect(messageFinder, findsOneWidget);
    });

    testWidgets('should displays an info icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoMessage(text: messageText),
          ),
        ),
      );

      final iconFinder = find.byIcon(Icons.info);
      expect(iconFinder, findsOneWidget);
    });
  });
}

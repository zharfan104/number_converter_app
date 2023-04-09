import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_converter_app/modules/number_converter/pages/number_to_words_converter_page.dart';
import 'package:number_converter_app/modules/number_converter/pages/widgets/number_to_words_converter_body.dart';
import 'package:number_converter_app/modules/number_converter/pages/widgets/number_to_words_converter_drawer.dart';

void main() {
  testWidgets(
    'NumberToWordsConverterPage has app bar, body, and drawer',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NumberToWordsConverterPage(),
        ),
      );

      // Verify if AppBar is found
      expect(find.byType(AppBar), findsOneWidget);

      // Verify if the AppBar title text is "Converter App"
      expect(find.text('Number Converter App'), findsOneWidget);

      // Verify if NumberToWordsConverterBody is found
      expect(find.byType(NumberToWordsConverterBody), findsOneWidget);

      // Open the drawer by tapping the hamburger icon
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Verify if NumberToWordsConverterDrawer is found
      expect(find.byType(NumberToWordsConverterDrawer), findsOneWidget);
    },
  );
}

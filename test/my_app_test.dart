import 'package:flutter_test/flutter_test.dart';
import 'package:number_converter_app/modules/number_converter/pages/number_to_words_converter_page.dart';

import 'package:number_converter_app/my_app.dart';

void main() {
  testWidgets(
    'MyApp has NumberToWordsConverterPage',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.byType(NumberToWordsConverterPage), findsOneWidget);
    },
  );
}

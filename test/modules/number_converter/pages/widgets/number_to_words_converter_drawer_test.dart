import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_converter_app/modules/number_converter/pages/widgets/number_to_words_converter_drawer.dart';

void main() {
  group('NumberToWordsConverterDrawer Widget', () {
    testWidgets(
      'should display the app title in the drawer header',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              appBar: AppBar(),
              drawer: const NumberToWordsConverterDrawer(),
            ),
          ),
        );

        // Open the drawer by tapping the hamburger icon
        await tester.tap(find.byIcon(Icons.menu));
        await tester.pumpAndSettle();

        final appTitleFinder = find.text('Number to Words Converter App');
        expect(appTitleFinder, findsOneWidget);

        final drawerHeaderFinder = find.byType(DrawerHeader);
        expect(drawerHeaderFinder, findsOneWidget);
      },
    );

    testWidgets(
      'should display the app info dialog when the "App Info" list tile is tapped',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              appBar: AppBar(),
              drawer: const NumberToWordsConverterDrawer(),
            ),
          ),
        );

        // Open the drawer by tapping the hamburger icon
        await tester.tap(find.byIcon(Icons.menu));
        await tester.pumpAndSettle();

        final appInfoFinder = find.text('App Info');
        expect(appInfoFinder, findsOneWidget);

        await tester.tap(appInfoFinder);
        await tester.pumpAndSettle();

        final dialogFinder = find.byType(AlertDialog);
        expect(dialogFinder, findsOneWidget);

        final dialogTitleFinder = find.text('About App');
        expect(dialogTitleFinder, findsOneWidget);

        final dialogContentFinder = find.text('This is a Number to Words converter app. Created by @zharfan104');
        expect(dialogContentFinder, findsOneWidget);

        final closeButtonFinder = find.text('Close');
        expect(closeButtonFinder, findsOneWidget);

        await tester.tap(closeButtonFinder);
        await tester.pumpAndSettle();

        expect(dialogFinder, findsNothing);
      },
    );
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_converter_app/common/widgets/custom_text_field.dart';

void main() {
  group('CustomTextField Widget Test', () {
    const labelText = 'Label';
    const initialValue = 'Initial Value';
    const hintText = 'Hint Text';
    const errorMessage = 'Error Message';
    const newErrorMessage = 'New Error Message';

    testWidgets(
      'CustomTextField should display the provided labelText, initialValue, and hintText correctly, and not show the error message (and the icons) when it is null',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: CustomTextField(
                labelText: labelText,
                initialValue: initialValue,
                hintText: hintText,
              ),
            ),
          ),
        );

        expect(find.text(labelText), findsOneWidget);
        expect(find.text(initialValue), findsOneWidget);
        expect(find.text(hintText), findsOneWidget);
        expect(find.text(errorMessage), findsNothing);
        expect(find.text(newErrorMessage), findsNothing);
        final iconButton = find.byIcon(Icons.info);
        expect(iconButton, findsNothing);
      },
    );

    testWidgets(
      'CustomTextField should show and hide the error tooltip when tapping the info icon',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: CustomTextField(
                labelText: labelText,
                initialValue: initialValue,
                errorMessage: errorMessage,
              ),
            ),
          ),
        );

        expect(find.text(errorMessage), findsNothing);

        final iconButton = find.byIcon(Icons.info);
        expect(iconButton, findsOneWidget);

        await tester.tap(iconButton);
        await tester.pumpAndSettle();

        expect(find.text(errorMessage), findsOneWidget);

        await tester.tap(iconButton);
        await tester.pumpAndSettle();

        expect(find.text(errorMessage), findsNothing);
      },
    );

    testWidgets(
      'CustomTextField should update the error tooltip message and display the new message on didUpdateWidget',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: _CustomTextFieldTestWrapper(),
            ),
          ),
        );

        final iconButton = find.byIcon(Icons.info);
        expect(iconButton, findsNothing);

        final _CustomTextFieldTestWrapperState testWrapperState =
            tester.state(find.byType(_CustomTextFieldTestWrapper));
        testWrapperState.updateErrorMessage(errorMessage);
        await tester.pumpAndSettle();

        expect(iconButton, findsOneWidget);
        expect(find.text(errorMessage), findsOneWidget);

        await tester.tap(iconButton);
        await tester.pumpAndSettle();

        expect(find.text(errorMessage), findsNothing);

        testWrapperState.updateErrorMessage(newErrorMessage);
        await tester.pumpAndSettle();

        expect(find.text(errorMessage), findsNothing);
        expect(find.text(newErrorMessage), findsOneWidget);
      },
    );
  });
}

class _CustomTextFieldTestWrapper extends StatefulWidget {
  const _CustomTextFieldTestWrapper();

  @override
  State<_CustomTextFieldTestWrapper> createState() => _CustomTextFieldTestWrapperState();
}

class _CustomTextFieldTestWrapperState extends State<_CustomTextFieldTestWrapper> {
  String? errorMessage;

  void updateErrorMessage(String? newErrorMessage) {
    setState(() {
      errorMessage = newErrorMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: 'Label',
      initialValue: 'Initial Value',
      hintText: 'Hint Text',
      errorMessage: errorMessage,
    );
  }
}

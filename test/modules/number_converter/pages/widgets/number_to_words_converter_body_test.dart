import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_converter_app/common/widgets/custom_text_field.dart';
import 'package:number_converter_app/common/widgets/info_message.dart';
import 'package:number_converter_app/modules/number_converter/cubits/number_to_words_converter_cubit.dart';
import 'package:number_converter_app/modules/number_converter/cubits/number_to_words_converter_state.dart';
import 'package:number_converter_app/modules/number_converter/pages/widgets/number_to_words_converter_body.dart';

class MockNumberToWordsConverterCubit extends MockCubit<NumberToWordsConverterState>
    implements NumberToWordsConverterCubit {}

void main() {
  group('NumberToWordsConverterBody', () {
    late NumberToWordsConverterCubit cubit;

    setUp(() {
      cubit = MockNumberToWordsConverterCubit();
    });

    testWidgets(
      'should display input and output fields, a convert button, and an info message',
      (WidgetTester tester) async {
        when(() => cubit.state).thenReturn(const NumberToWordsConverterState.initial());

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: cubit,
                child: const NumberToWordsConverterBody(),
              ),
            ),
          ),
        );

        final inputTextFieldFinder = find.byWidgetPredicate(
          (widget) => widget is CustomTextField && widget.labelText == 'Input Number',
        );

        expect(inputTextFieldFinder, findsOneWidget);
        expect(find.text('Input Number'), findsOneWidget);

        final outputTextFieldFinder = find.byWidgetPredicate(
          (widget) => widget is CustomTextField && widget.labelText == 'Answer:',
        );
        expect(outputTextFieldFinder, findsOneWidget);
        expect(find.text('Answer:'), findsOneWidget);

        expect(find.byType(InfoMessage), findsOneWidget);
        expect(
          find.text('Enter a number in the input box and tap Convert to see the equivalent in words in the output box'),
          findsOneWidget,
        );

        expect(find.byType(ElevatedButton), findsOneWidget);
      },
    );

    testWidgets(
      'should accept valid decimal numbers without fractions in the input field',
      (WidgetTester tester) async {
        when(() => cubit.state).thenReturn(const NumberToWordsConverterState.initial());

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: cubit,
                child: const NumberToWordsConverterBody(),
              ),
            ),
          ),
        );

        final inputTextFieldFinder = find.byWidgetPredicate(
          (widget) => widget is CustomTextField && widget.labelText == 'Input Number',
        );

        await tester.enterText(inputTextFieldFinder, '12345');
        await tester.pumpAndSettle();

        expect(find.text('12345'), findsOneWidget);
        verify(() => cubit.updateInputNumber('12345'));
      },
    );

    testWidgets(
      'should not accept alphabets in the input field, only decimal numbers',
      (WidgetTester tester) async {
        when(() => cubit.state).thenReturn(const NumberToWordsConverterState.initial());

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: cubit,
                child: const NumberToWordsConverterBody(),
              ),
            ),
          ),
        );

        final inputTextFieldFinder = find.byWidgetPredicate(
          (widget) => widget is CustomTextField && widget.labelText == 'Input Number',
        );

        await tester.enterText(inputTextFieldFinder, '-13a5');
        await tester.pumpAndSettle();

        expect(find.text('-13a5'), findsNothing);
      },
    );

    testWidgets(
      'should not accept fractions in the input field, only decimal numbers',
      (WidgetTester tester) async {
        when(() => cubit.state).thenReturn(const NumberToWordsConverterState.initial());

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: cubit,
                child: const NumberToWordsConverterBody(),
              ),
            ),
          ),
        );

        final inputTextFieldFinder = find.byWidgetPredicate(
          (widget) => widget is CustomTextField && widget.labelText == 'Input Number',
        );

        await tester.enterText(inputTextFieldFinder, '13.5');
        await tester.pumpAndSettle();

        expect(find.text('13.5'), findsNothing);
      },
    );

    testWidgets(
      'should have a read-only output field',
      (WidgetTester tester) async {
        when(() => cubit.state).thenReturn(const NumberToWordsConverterState.initial());

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider<NumberToWordsConverterCubit>.value(
                value: cubit,
                child: const NumberToWordsConverterBody(),
              ),
            ),
          ),
        );

        final outputTextFieldFinder = find.byWidgetPredicate(
          (widget) => widget is CustomTextField && widget.labelText == 'Answer:',
        );

        await tester.enterText(outputTextFieldFinder, '100');
        await tester.pumpAndSettle();

        expect(find.text('100'), findsNothing);
      },
    );

    testWidgets('should trigger conversion when tapping the "Convert" button', (WidgetTester tester) async {
      when(() => cubit.state).thenReturn(const NumberToWordsConverterState.initial());

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: cubit,
              child: const NumberToWordsConverterBody(),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(CustomTextField).first, '13');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      verify(() => cubit.convert());
    });

    testWidgets(
      'should show the correct conversion of 999999999999999 to words in the output field',
      (WidgetTester tester) async {
        when(() => cubit.state).thenReturn(
          const NumberToWordsConverterState.converted(
            inputNumber: '999999999999999',
            outputWords:
                'Nine hundred ninety-nine trillion nine hundred ninety-nine billion nine hundred ninety-nine million nine hundred ninety-nine thousand nine hundred ninety-nine',
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: cubit,
                child: const NumberToWordsConverterBody(),
              ),
            ),
          ),
        );

        await tester.pump();

        // Verify that the 'Output' textfield shows the correct value
        expect(
          find.text(
            'Nine hundred ninety-nine trillion nine hundred ninety-nine billion nine hundred ninety-nine million nine hundred ninety-nine thousand nine hundred ninety-nine',
          ),
          findsOneWidget,
        );
      },
    );
  });
}

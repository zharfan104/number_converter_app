import 'package:flutter_test/flutter_test.dart';
import 'package:number_converter_app/modules/number_converter/cubits/number_to_words_converter_state.dart';

void main() {
  group('NumberToWordsConverterState', () {
    test(
      'initial state has empty inputNumber, outputWords, and null errorMessage',
      () {
        const initialState = NumberToWordsConverterState.initial();
        expect(initialState.inputNumber, '');
        expect(initialState.outputWords, '');
        expect(initialState.errorMessage, null);
      },
    );

    test('error state has errorMessage and previousInputNumber', () {
      const errorState = NumberToWordsConverterState.error(
        errorMessage: 'Invalid input',
        previousInputNumber: '123',
      );
      expect(errorState.inputNumber, '123');
      expect(errorState.outputWords, '');
      expect(errorState.errorMessage, 'Invalid input');
    });

    test('converted state has inputNumber and outputWords', () {
      const convertedState = NumberToWordsConverterState.converted(
        inputNumber: '123',
        outputWords: 'One hundred twenty-three',
      );
      expect(convertedState.inputNumber, '123');
      expect(convertedState.outputWords, 'One hundred twenty-three');
      expect(convertedState.errorMessage, null);
    });

    test('inputChanged state has inputNumber and previousOutputWords', () {
      const inputChangedState = NumberToWordsConverterState.inputChanged(
        inputNumber: '123',
        previousOutputWords: 'outputWords',
      );
      expect(inputChangedState.inputNumber, '123');
      expect(inputChangedState.outputWords, 'outputWords');
      expect(inputChangedState.errorMessage, null);
    });
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_converter_app/modules/number_converter/cubits/number_to_words_converter_cubit.dart';
import 'package:number_converter_app/modules/number_converter/cubits/number_to_words_converter_state.dart';

void main() {
  group('NumberToWordsConverterCubit', () {
    late NumberToWordsConverterCubit cubit;

    setUp(() {
      cubit = NumberToWordsConverterCubit();
    });

    tearDown(() async {
      await cubit.close();
    });

    test('initial state is NumberToWordsConverterState.initial()', () {
      expect(cubit.state, const NumberToWordsConverterState.initial());
    });

    blocTest<NumberToWordsConverterCubit, NumberToWordsConverterState>(
      'updates inputNumber and previousOutputWords when updateInputNumber is called',
      build: () => cubit,
      act: (cubit) => cubit.updateInputNumber('123'),
      expect: () => const [
        NumberToWordsConverterState.inputChanged(inputNumber: '123', previousOutputWords: ''),
      ],
    );

    group('convert() emits error state', () {
      blocTest<NumberToWordsConverterCubit, NumberToWordsConverterState>(
        'emits error state when input is empty',
        build: () => cubit,
        act: (cubit) {
          cubit.updateInputNumber('');
          cubit.convert();
        },
        expect: () => const [
          NumberToWordsConverterState.inputChanged(
            inputNumber: '',
            previousOutputWords: '',
          ),
          NumberToWordsConverterState.error(
            errorMessage: 'Input is empty',
            previousInputNumber: '',
          ),
        ],
      );

      blocTest<NumberToWordsConverterCubit, NumberToWordsConverterState>(
        'emits error state when input has leading zeros (00123)',
        build: () => cubit,
        act: (cubit) {
          cubit.updateInputNumber('00123');
          cubit.convert();
        },
        expect: () => const [
          NumberToWordsConverterState.inputChanged(inputNumber: '00123', previousOutputWords: ''),
          NumberToWordsConverterState.error(errorMessage: 'Input has leading zeros', previousInputNumber: '00123'),
        ],
      );

      blocTest<NumberToWordsConverterCubit, NumberToWordsConverterState>(
        'emits error state when input has leading zeros (-00123)',
        build: () => cubit,
        act: (cubit) {
          cubit.updateInputNumber('-00123');
          cubit.convert();
        },
        expect: () => const [
          NumberToWordsConverterState.inputChanged(inputNumber: '-00123', previousOutputWords: ''),
          NumberToWordsConverterState.error(errorMessage: 'Input has leading zeros', previousInputNumber: '-00123'),
        ],
      );

      blocTest<NumberToWordsConverterCubit, NumberToWordsConverterState>(
        'emits error state when input contains a decimal point',
        build: () => cubit,
        act: (cubit) {
          cubit.updateInputNumber('123.45');
          cubit.convert();
        },
        expect: () => const [
          NumberToWordsConverterState.inputChanged(inputNumber: '123.45', previousOutputWords: ''),
          NumberToWordsConverterState.error(
            errorMessage: 'Input contains a decimal point',
            previousInputNumber: '123.45',
          ),
        ],
      );

      blocTest<NumberToWordsConverterCubit, NumberToWordsConverterState>(
        'emits error state when input contains a comma',
        build: () => cubit,
        act: (cubit) {
          cubit.updateInputNumber('123,45');
          cubit.convert();
        },
        expect: () => const [
          NumberToWordsConverterState.inputChanged(inputNumber: '123,45', previousOutputWords: ''),
          NumberToWordsConverterState.error(errorMessage: 'Input contains a comma', previousInputNumber: '123,45'),
        ],
      );

      blocTest<NumberToWordsConverterCubit, NumberToWordsConverterState>(
        'emits error state when input is not a valid number',
        build: () => cubit,
        act: (cubit) {
          cubit.updateInputNumber('12a34');
          cubit.convert();
        },
        expect: () => const [
          NumberToWordsConverterState.inputChanged(inputNumber: '12a34', previousOutputWords: ''),
          NumberToWordsConverterState.error(errorMessage: 'Input is not a valid number', previousInputNumber: '12a34'),
        ],
      );

      blocTest<NumberToWordsConverterCubit, NumberToWordsConverterState>(
        'emits error state when input number exceeds the maximum allowed value',
        build: () => cubit,
        act: (cubit) {
          cubit.updateInputNumber('1000000000000000');
          cubit.convert();
        },
        expect: () => const [
          NumberToWordsConverterState.inputChanged(inputNumber: '1000000000000000', previousOutputWords: ''),
          NumberToWordsConverterState.error(
            errorMessage: 'Input number exceeds the allowed range',
            previousInputNumber: '1000000000000000',
          ),
        ],
      );

      blocTest<NumberToWordsConverterCubit, NumberToWordsConverterState>(
        'emits error state when input number exceeds the minimum allowed value',
        build: () => cubit,
        act: (cubit) {
          cubit.updateInputNumber('-1000000000000000');
          cubit.convert();
        },
        expect: () => const [
          NumberToWordsConverterState.inputChanged(inputNumber: '-1000000000000000', previousOutputWords: ''),
          NumberToWordsConverterState.error(
            errorMessage: 'Input number exceeds the allowed range',
            previousInputNumber: '-1000000000000000',
          ),
        ],
      );

      blocTest<NumberToWordsConverterCubit, NumberToWordsConverterState>(
        'emits error state when input contains a space',
        build: () => cubit,
        act: (cubit) {
          cubit.updateInputNumber('12 34');
          cubit.convert();
        },
        expect: () => const [
          NumberToWordsConverterState.inputChanged(inputNumber: '12 34', previousOutputWords: ''),
          NumberToWordsConverterState.error(errorMessage: 'Input is not a valid number', previousInputNumber: '12 34'),
        ],
      );

      blocTest<NumberToWordsConverterCubit, NumberToWordsConverterState>(
        'emits error state when input has a negative sign in the middle',
        build: () => cubit,
        act: (cubit) {
          cubit.updateInputNumber('12-34');
          cubit.convert();
        },
        expect: () => const [
          NumberToWordsConverterState.inputChanged(inputNumber: '12-34', previousOutputWords: ''),
          NumberToWordsConverterState.error(errorMessage: 'Input is not a valid number', previousInputNumber: '12-34'),
        ],
      );
    });

    group('convert() emits converted state', () {
      void testWithInputNumber(
        String inputNumber,
        String outputWords,
      ) {
        blocTest<NumberToWordsConverterCubit, NumberToWordsConverterState>(
          'emits error when convert is called with input $inputNumber',
          build: () => cubit,
          act: (cubit) {
            cubit.updateInputNumber(inputNumber);
            cubit.convert();
          },
          expect: () => [
            NumberToWordsConverterState.inputChanged(inputNumber: inputNumber, previousOutputWords: ''),
            NumberToWordsConverterState.converted(
              inputNumber: inputNumber,
              outputWords: outputWords,
            ),
          ],
        );
      }

      group('Zero Number', () {
        testWithInputNumber('0', 'Zero');
      });

      group('Positive Input Number', () {
        testWithInputNumber('1', 'One');
        testWithInputNumber('10', 'Ten');
        testWithInputNumber('11', 'Eleven');
        testWithInputNumber('12', 'Twelve');
        testWithInputNumber('13', 'Thirteen');
        testWithInputNumber('19', 'Nineteen');
        testWithInputNumber('20', 'Twenty');
        testWithInputNumber('21', 'Twenty-one');
        testWithInputNumber('29', 'Twenty-nine');
        testWithInputNumber('51', 'Fifty-one');
        testWithInputNumber('59', 'Fifty-nine');
        testWithInputNumber('89', 'Eighty-nine');
        testWithInputNumber('100', 'One hundred');
        testWithInputNumber('101', 'One hundred one');
        testWithInputNumber('123', 'One hundred twenty-three');
        testWithInputNumber('111', 'One hundred eleven');
        testWithInputNumber('1000', 'One thousand');
        testWithInputNumber('1073', 'One thousand seventy-three');
        testWithInputNumber('10000', 'Ten thousand');
        testWithInputNumber('12345', 'Twelve thousand three hundred forty-five');
        testWithInputNumber('921503', 'Nine hundred twenty-one thousand five hundred three');
        testWithInputNumber('100000', 'One hundred thousand');
        testWithInputNumber('1000000', 'One million');
        testWithInputNumber('1000000000', 'One billion');
        testWithInputNumber('1000000000000', 'One trillion');
      });

      group('Negative Input Number', () {
        testWithInputNumber('-1', 'Negative one');
        testWithInputNumber('-10', 'Negative ten');
        testWithInputNumber('-11', 'Negative eleven');
        testWithInputNumber('-12', 'Negative twelve');
        testWithInputNumber('-13', 'Negative thirteen');
        testWithInputNumber('-19', 'Negative nineteen');
        testWithInputNumber('-20', 'Negative twenty');
        testWithInputNumber('-21', 'Negative twenty-one');
        testWithInputNumber('-29', 'Negative twenty-nine');
        testWithInputNumber('-51', 'Negative fifty-one');
        testWithInputNumber('-59', 'Negative fifty-nine');
        testWithInputNumber('-89', 'Negative eighty-nine');
        testWithInputNumber('-100', 'Negative one hundred');
        testWithInputNumber('-101', 'Negative one hundred one');
        testWithInputNumber('-123', 'Negative one hundred twenty-three');
        testWithInputNumber('-111', 'Negative one hundred eleven');
        testWithInputNumber('-1000', 'Negative one thousand');
        testWithInputNumber('-1073', 'Negative one thousand seventy-three');
        testWithInputNumber('-10000', 'Negative ten thousand');
        testWithInputNumber('-12345', 'Negative twelve thousand three hundred forty-five');
        testWithInputNumber('-921503', 'Negative nine hundred twenty-one thousand five hundred three');
        testWithInputNumber('-100000', 'Negative one hundred thousand');
        testWithInputNumber('-1000000', 'Negative one million');
        testWithInputNumber('-1000000000', 'Negative one billion');
        testWithInputNumber('-1000000000000', 'Negative one trillion');
      });

      group('Boundary Input Number', () {
        testWithInputNumber(
          '999999999999999',
          'Nine hundred ninety-nine trillion nine hundred ninety-nine billion nine hundred ninety-nine million nine hundred ninety-nine thousand nine hundred ninety-nine',
        );
        testWithInputNumber(
          '-999999999999999',
          'Negative nine hundred ninety-nine trillion nine hundred ninety-nine billion nine hundred ninety-nine million nine hundred ninety-nine thousand nine hundred ninety-nine',
        );
      });
    });
  });
}

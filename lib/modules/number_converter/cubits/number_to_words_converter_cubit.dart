import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/utils/string_extension.dart';

import 'number_to_words_converter_state.dart';

const _kMaximumNumberAllowed = 999999999999999;

class NumberToWordsConverterCubit extends Cubit<NumberToWordsConverterState> {
  NumberToWordsConverterCubit() : super(const NumberToWordsConverterState.initial());

  void updateInputNumber(String inputNumber) {
    emit(NumberToWordsConverterState.inputChanged(
      inputNumber: inputNumber,
      previousOutputWords: state.outputWords,
    ));
  }

  void convert() {
    final inputNumber = state.inputNumber;

    final errorMessage = _inputValidator(inputNumber);

    if (errorMessage == null) {
      convertNumberToWords(inputNumber);
    } else {
      emit(NumberToWordsConverterState.error(
        errorMessage: errorMessage,
        previousInputNumber: inputNumber,
      ));
    }
  }

  // Return null if the input is valid
  String? _inputValidator(String inputNumber) {
    if (inputNumber.isEmpty) return 'Input is empty';
    if (inputNumber.length > 1 && (inputNumber.startsWith('0') || inputNumber.startsWith('-0'))) {
      return 'Input has leading zeros';
    }
    if (inputNumber.contains('.')) return 'Input contains a decimal point';
    if (inputNumber.contains(',')) return 'Input contains a comma';

    final BigInt? parsedNumber = BigInt.tryParse(inputNumber);
    if (parsedNumber == null) return 'Input is not a valid number';

    if (parsedNumber.abs() > BigInt.from(_kMaximumNumberAllowed)) {
      return 'Input number exceeds the allowed range';
    }

    return null;
  }

  void convertNumberToWords(String inputNumber) {
    if (inputNumber == '0') {
      emit(
        NumberToWordsConverterState.converted(inputNumber: inputNumber, outputWords: 'Zero'),
      );

      return;
    }

    final isNegative = inputNumber.startsWith('-');
    final positiveNumber = isNegative ? inputNumber.substring(1) : inputNumber;

    String tempNumber = positiveNumber;
    final segments = <String>[];
    int bigsIndex = 0;

    const bigs = ['', 'thousand', 'million', 'billion', 'trillion'];

    while (tempNumber.isNotEmpty) {
      final segmentLength = (tempNumber.length > 3) ? 3 : tempNumber.length;
      final segmentIndex = tempNumber.length - segmentLength;
      final segment = tempNumber.substring(segmentIndex);
      tempNumber = tempNumber.substring(0, segmentIndex);

      String segmentText = _convertSegment(segment);

      if (segmentText.isNotEmpty) {
        if (bigsIndex > 0) {
          segmentText += ' ${bigs[bigsIndex]}';
        }
        segments.insert(0, segmentText);
      }

      bigsIndex++;
    }

    String outputWords = segments.join(' ');
    if (isNegative) {
      outputWords = 'negative $outputWords';
    }

    emit(NumberToWordsConverterState.converted(
      inputNumber: inputNumber,
      outputWords: outputWords.capitalize(),
    ));
  }

  String _convertSegment(String segment) {
    const units = ['', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'];

    const teens = [
      'ten',
      'eleven',
      'twelve',
      'thirteen',
      'fourteen',
      'fifteen',
      'sixteen',
      'seventeen',
      'eighteen',
      'nineteen',
    ];

    const tens = ['', '', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'];

    int num = int.parse(segment);
    final parts = <String>[];
    bool isTensIncluded = false;

    if (num >= 100) {
      parts.add('${units[num ~/ 100]} hundred');
      num %= 100;
    }

    if (num >= 10 && num <= 19) {
      parts.add(teens[num - 10]);
    } else {
      if (num >= 20) {
        parts.add(tens[num ~/ 10]);
        isTensIncluded = true;
      }
      num %= 10;
      if (num > 0) {
        if (parts.isNotEmpty) {
          if (isTensIncluded) {
            parts.add('-');
          }
        }
        parts.add(units[num]);
      }
    }

    return parts.join(' ').replaceAll(' - ', '-').capitalize();
  }
}

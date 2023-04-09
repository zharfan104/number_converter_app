import 'package:equatable/equatable.dart';

class NumberToWordsConverterState extends Equatable {
  const NumberToWordsConverterState.initial()
      : inputNumber = '',
        outputWords = '',
        errorMessage = null;

  const NumberToWordsConverterState.error({
    required this.errorMessage,
    required String previousInputNumber,
  })  : inputNumber = previousInputNumber,
        outputWords = '';

  const NumberToWordsConverterState.converted({
    required this.inputNumber,
    required this.outputWords,
  }) : errorMessage = null;

  const NumberToWordsConverterState.inputChanged({
    required this.inputNumber,
    required String previousOutputWords,
  })  : outputWords = previousOutputWords,
        errorMessage = null;

  final String inputNumber;
  final String outputWords;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        inputNumber,
        outputWords,
        errorMessage,
      ];
}

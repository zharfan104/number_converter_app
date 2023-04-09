import 'package:equatable/equatable.dart';

class NumberToWordsState extends Equatable {
  const NumberToWordsState.initial()
      : inputNumber = '',
        outputWords = '',
        errorMessage = null;

  const NumberToWordsState.error({
    required this.errorMessage,
    required String previousInputNumber,
  })  : inputNumber = previousInputNumber,
        outputWords = '';

  const NumberToWordsState.converted({
    required this.inputNumber,
    required this.outputWords,
  }) : errorMessage = null;

  const NumberToWordsState.inputChanged({
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

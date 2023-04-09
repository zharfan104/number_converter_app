import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/ui/size_constants.dart';
import '../../../../common/utils/decimal_input_formatter.dart';
import '../../../../common/widgets/custom_text_field.dart';
import '../../../../common/widgets/info_message.dart';
import '../../cubits/number_to_words_cubit.dart';
import '../../cubits/number_to_words_state.dart';

const _kOutputWordsMaxLines = 4;

class NumberToWordsConverterBody extends StatelessWidget {
  const NumberToWordsConverterBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kSpacingMedium),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: kSpacingSmall),
            const InfoMessage(
              text: 'Enter a number in the input box and tap Convert to see the equivalent in words in the output box',
            ),
            const SizedBox(height: kSpacingMedium),
            BlocBuilder<NumberToWordsCubit, NumberToWordsState>(
              builder: (context, state) {
                return CustomTextField(
                  labelText: 'Input Number',
                  onChanged: context.read<NumberToWordsCubit>().updateInputNumber,
                  errorMessage: state.errorMessage,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    DecimalInputFormatter(),
                  ],
                  hintText: 'Enter a number to convert',
                );
              },
            ),
            const SizedBox(height: kSpacingMedium),
            BlocBuilder<NumberToWordsCubit, NumberToWordsState>(
              builder: (context, state) {
                return CustomTextField(
                  key: ValueKey(state.outputWords),
                  labelText: 'Answer:',
                  initialValue: state.outputWords,
                  readOnly: true,
                  maxLines: _kOutputWordsMaxLines,
                );
              },
            ),
            const SizedBox(height: kSpacingMedium),
            ElevatedButton(
              onPressed: context.read<NumberToWordsCubit>().convert,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kSpacingMedium),
                child: Text(
                  'Convert',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

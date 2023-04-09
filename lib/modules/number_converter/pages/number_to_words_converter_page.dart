import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/number_to_words_converter_cubit.dart';
import 'widgets/number_to_words_converter_body.dart';
import 'widgets/number_to_words_converter_drawer.dart';

class NumberToWordsConverterPage extends StatelessWidget {
  const NumberToWordsConverterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NumberToWordsConverterCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Converter App')),
        body: const NumberToWordsConverterBody(),
        drawer: const NumberToWordsConverterDrawer(),
      ),
    );
  }
}

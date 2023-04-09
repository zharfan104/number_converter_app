import 'package:flutter/material.dart';

import 'common/ui/app_colors.dart';
import 'common/ui/app_text_theme.dart';
import 'modules/number_converter/pages/number_to_words_converter_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number To Words Converter App',
      theme: ThemeData(
        textTheme: appTextTheme,
        primaryColor: AppColors.lightGrey,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.lightGrey,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.lightGrey),
        ),
      ),
      home: const NumberToWordsConverterPage(),
    );
  }
}

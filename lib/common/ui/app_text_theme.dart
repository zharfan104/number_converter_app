import 'package:flutter/material.dart';

const appTextTheme = TextTheme(
  displayMedium: _displayMediumTextStyle,
  displaySmall: _displaySmallTextStyle,
  bodyLarge: _bodyLargeTextStyle,
  bodyMedium: _bodyMediumTextStyle,
  labelLarge: _labelLargeTextStyle,
);

const TextStyle _displayMediumTextStyle = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const TextStyle _displaySmallTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const TextStyle _bodyLargeTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.normal,
  color: Colors.black,
);

const TextStyle _bodyMediumTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
  color: Colors.black,
);

const TextStyle _labelLargeTextStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.normal,
  color: Colors.grey,
);

# Number Converter App

A Flutter app that converts numbers to words using a custom-built number to words converter.

## Screenshot/Video


## Supported Features

- [x] Convert decimal numbers without fractions to words
- [x] The limit number that can be converted is 999999999999999
- [x] Error tooltip for invalid input
- [x] Dismissable error tooltip by tapping the 'i' icon

### Packages in use

- [equatable](https://pub.dev/packages/equatable) for creating objects that can be easily compared
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) for integrating `bloc` with Flutter
- [mocktail](https://pub.dev/packages/mocktail) for creating mock data for testing

### Dev dependencies

- [bloc_test](https://pub.dev/packages/bloc_test) for testing `bloc` implementations
- [flutter_test](https://flutter.dev/docs/testing) for testing Flutter apps
- [all_lint_rules_community](https://pub.dev/packages/all_lint_rules_community) for linting rules
- [dart_code_metrics](https://pub.dev/packages/dart_code_metrics) for analyzing code metrics and providing additional static analysis
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) for customizing launcher icons

## Running the App

To run the app, follow these steps:

1. Clone the repository or download the source code.
2. Open the project in your favorite IDE or text editor.
3. Run `flutter pub get` to install the dependencies.
4. Run `flutter run` to start the app on your device or simulator.

That's it! The app should now be running on your device or simulator.

### Testing and Code Coverage

This app has been tested using the `flutter_test` package. Ensure your tests cover the core functionality of the app. Currently, it has 100% code coverage.

## TODO (what will be done after this)

- [ ] Improve the UI/UX of the app
- [ ] Add support for localization
- [ ] Improve error handling and user feedback

## Conclusion

With this app, you now have a good example of how to build a simple number converter app in Flutter. You can use this as a starting point for your own conversion app or as a learning resource to better understand how to work with input validation and custom conversions in Flutter.


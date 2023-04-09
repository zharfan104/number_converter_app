# Number Converter App

A Flutter app that converts numbers to words using a custom-built number to words converter using BloC state management.

## Video
### Android:

https://user-images.githubusercontent.com/39690358/230778481-6f34555e-f09c-45c2-9872-6539eb5ad2c6.mov

### Web (Chrome):

https://user-images.githubusercontent.com/39690358/230778607-8e9a6214-df91-4ec0-964a-57a9cea2fe20.mov



## Supported Features

- [x] Convert decimal numbers without fractions to words
- [x] The limit number that can be converted is 999999999999999/-999999999999999
- [x] Error tooltip for invalid input
- [x] Dismissable error tooltip by tapping the 'i' icon
- [x] 100% code coverage (unit tests and widget tests)
- [x] Tested on Android and Web (Chrome)
- [x] Developed using Flutter 3.7.9
- [x] GitHub Actions CI pipeline for Testing, Formatting, Analyzing, and Building APK

## Packages in use

- [equatable](https://pub.dev/packages/equatable) for creating objects that can be easily compared
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) for integrating `bloc` with Flutter

## Dev dependencies

- [bloc_test](https://pub.dev/packages/bloc_test) for testing `bloc` implementations
- [flutter_test](https://flutter.dev/docs/testing) for testing Flutter apps
- [all_lint_rules_community](https://pub.dev/packages/all_lint_rules_community) for linting rules
- [dart_code_metrics](https://pub.dev/packages/dart_code_metrics) for analyzing code metrics and providing additional static analysis
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) for customizing launcher icons
- [mocktail](https://pub.dev/packages/mocktail) for creating mock data for testing

## Running the App

To run the app, follow these steps:

1. Clone the repository or download the source code.
2. Open the project in your favorite IDE or text editor.
3. Run `flutter pub get` to install the dependencies.
4. Run `flutter run` to start the app on your device or simulator.

That's it! The app should now be running on your device or simulator.

## Testing and Code Coverage

This app is thoroughly tested using the `flutter_test` package to ensure the reliability and maintainability of the codebase. It currently boasts 100% code coverage, which means that all lines of code are executed during testing, providing confidence in the app's core functionality.
To generate and view the code coverage report, follow these steps:

1. Run tests with coverage `flutter test --coverage`
2. Generate an HTML report `genhtml coverage/lcov.info -o coverage/html`
3. Open the generated HTML report in your browser `open coverage/html/index.html`

![Screenshot 2023-04-09 at 21 21 20](https://user-images.githubusercontent.com/39690358/230778188-09292a86-58fa-4e28-bf75-ba4e1fc1a978.png)


By following the steps above, you can ensure that your tests continue to cover the core functionality of the app as you make changes and improvements. Strive to maintain or improve the code coverage percentage for a robust and dependable application.

## TODO

- [ ] Improve the UI/UX of the app
- [ ] Add support for localization using [flutter_localization](https://flutter.dev/docs/development/accessibility-and-localization/internationalization) 
- [ ] Use [flutter_gen](https://pub.dev/packages/flutter_gen) to generate image assets for the app
- [ ] Implement integration test
- [ ] Implement [AutoRoute](https://pub.dev/packages/auto_route) for declarative routing (when needed to do routing)

## Conclusion

With this app, you now have a good example of how to build a simple number converter app in Flutter. You can use this as a starting point for your own conversion app or as a learning resource to better understand how to work with input validation and custom conversions in Flutter.


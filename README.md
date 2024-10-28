# Flutter Dino #

[![pub package](https://img.shields.io/pub/v/flutter_dino.svg)](https://pub.dev/packages/flutter_dino)

[![package publisher](https://img.shields.io/pub/publisher/flutter_dino.svg)](https://pub.dev/packages/flutter_dino/publisher)

![GitHub code size](https://img.shields.io/github/languages/code-size/YudizAndroidKishan/flutter_dino)

**Flutter Dino** is a Flutter package that provides seamless internet connectivity handling in your Flutter applications. It allows you to easily manage and customize your app's behavior when internet connectivity changes.

## Features

- **Easy Integration**: Simple initialization process with minimal configuration
- **Customizable**: Full control over how your app handles connectivity changes
- **Global Access**: Works across your entire application
- **Custom UI Support**: Ability to show custom widgets when internet is unavailable
- **Automatic Handling**: Manages connectivity state changes without manual intervention

## Installation

Add the following line to your `pubspec.yaml` file under `dependencies`:

```yaml
dependencies:
  flutter_dino: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

To use **Flutter Dino** in your Flutter application:

### Import the Package

```dart
import 'package:flutter_dino/flutter_dino.dart';
```

### Basic Implementation

Here's a simple example of how to integrate Flutter Dino in your app:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_dino/flutter_dino.dart';

void main() async {
  final navigatorKey = GlobalKey<NavigatorState>();
  
  WidgetsFlutterBinding.ensureInitialized();
  
  await FlutterDino.initialize(
    config: FlutterDinoConfig(
      navigatorKey: navigatorKey,
    ),
  );
  
  runApp(
    MaterialApp(
      navigatorKey: navigatorKey,
      home: HomePage(),
    ),
  );
}
```

### Customization Options

You can customize Flutter Dino's behavior using `FlutterDinoConfig`:

```dart
FlutterDinoConfig(
  navigatorKey: navigatorKey,
  showNoInternetDialog: true,  // Control automatic handling
  noInternetReplacement: YourCustomWidget(),  // Custom UI when offline
)
```
## Demo

<img src="https://github.com/YudizAndroidKishan/flutter_dino/blob/3ac6536f243249bcfba58a70eb82a3ea997ff4c0/screenshots/flutter_dino.gif" width="240"/> 

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributors

[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)

<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://in.linkedin.com/in/kishan-sindhi"><img src="https://avatars.githubusercontent.com/u/171547052?v=4&size=64" width="100px;" alt="YudizAndroidKishan"/><br /><sub><b>YudizAndroidKishan</b></sub></a><br /><a href="#infra-YudizAndroidKishan" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="https://github.com/YudizAndroidKishan/flutter_dino/commits?author=YudizAndroidKishan" title="Tests">⚠️</a> <a href="https://github.com/YudizAndroidKishan/flutter_dino/commits?author=YudizAndroidKishan" title="Code">💻</a></td>
    </tr>
  </tbody>
</table>


## Contributions

Contributions are welcome! Please open an issue or submit a pull request on the [GitHub repository](https://github.com/YudizAndroidKishan/flutter_dino) if you would like to contribute to **Flutter Dino**.

## Support

If you encounter any issues or have questions, feel free to open an issue on [GitHub](https://github.com/YudizAndroidKishan/flutter_dino/issues).

## Visitors Count
<img align="left" src = "https://profile-counter.glitch.me/flutter_dino/count.svg" alt ="Loading">
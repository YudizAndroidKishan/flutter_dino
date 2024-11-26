// Singleton service to manage dialog
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dino/presentation/dino_provider.dart';

import '../config/flutter_dino_config.dart';

/// A service class that handles displaying dialogs without requiring BuildContext
class DialogServices {
  DialogServices._(); // Private constructor
  static DialogServices? _instance;
  static late FlutterDinoConfig _config;

  /// Gets the singleton instance of DialogUtils
  static DialogServices get instance {
    _instance ??= DialogServices._();
    return _instance!;
  }

  /// Initializes the DialogUtils with a navigator key
  static void initialize(FlutterDinoConfig config) {
    _config = config;
  }

  /// Shows a dialog using the stored navigator key
  Future<T?> showCustomDialog<T>({
    required Widget dialog,
    bool barrierDismissible = true,
  }) async {
    // Add safety check
    if (_config.navigatorKey.currentContext == null) {
      log(
        'Cannot show dialog: No valid context available',
        name: "Flutter Dino",
      );
      return null;
    }

    // Check if dialog is already showing
    if (_config.navigatorKey.currentState?.canPop() ?? false) {
      return null;
    }
    return showDialog<T>(
      context: _config.navigatorKey.currentContext!,
      barrierDismissible: barrierDismissible,
      builder: (context) => dialog,
    );
  }

  /// Shows a no internet connection dialog
  Future<void> showNoInternetDialog() async {
    await showCustomDialog(
      barrierDismissible: false,
      dialog: PopScope(
        canPop: false,
        child: _config.noInternetReplacement ?? const DinoProvider(),
      ),
    );
  }

  /// Dismisses any open dialogs
  void hideDialog() {
    if (_config.navigatorKey.currentContext != null &&
        Navigator.canPop(_config.navigatorKey.currentContext!)) {
      Navigator.pop(_config.navigatorKey.currentContext!);
    }
  }
}

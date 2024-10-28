import 'package:flutter/material.dart';

/// Configuration options for FlutterDino
class FlutterDinoConfig {
  /// Key used for navigation and dialog display
  final GlobalKey<NavigatorState> navigatorKey;

  /// Whether to show the no internet dialog automatically
  final bool showNoInternetDialog;

  /// A custom widget to show when there's no internet connection.
  ///
  /// If provided, this widget will be shown instead of the default dialog
  /// when internet connection is lost. This is useful when you want to show
  /// a custom UI like a full-screen error state or an in-app notification.
  ///
  /// Example usage:
  /// ```dart
  /// FlutterDinoConfig(
  ///   navigatorKey: navigatorKey,
  ///   noInternetReplacement: Container(
  ///     color: Colors.red,
  ///     child: Center(
  ///       child: Text('No Internet Connection'),
  ///     ),
  ///   ),
  /// )
  /// ```
  ///
  /// If [noInternetReplacement] is provided:
  /// - The default dialog will not be shown
  /// - This widget will be displayed using an [Overlay]
  /// - The widget will be automatically removed when internet connection is restored
  ///
  /// If null, the default no-internet dialog will be shown.
  final Widget? noInternetReplacement;

  const FlutterDinoConfig({
    required this.navigatorKey,
    this.showNoInternetDialog = true,
    this.noInternetReplacement,
  });
}

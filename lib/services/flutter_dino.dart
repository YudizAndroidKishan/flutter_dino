import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dino/config/flutter_dino_config.dart';

import 'dialog_services.dart';

/// Main class for handling internet connectivity monitoring
class FlutterDino {
  static FlutterDino? _instance;
  late StreamSubscription<List<ConnectivityResult>> _connectivityStream;
  bool _isHavingInternet = true;
  final FlutterDinoConfig _config;

  /// Whether the device currently has internet connectivity
  bool get hasInternet => _isHavingInternet;

  /// Gets the singleton instance of FlutterDino
  static FlutterDino get instance {
    if (_instance == null) {
      throw StateError(
        'FlutterDino not initialized. Call FlutterDino.initialize() first.',
      );
    }
    return _instance!;
  }

  /// Initializes the FlutterDino plugin with the provided configuration
  ///
  /// Must be called before accessing the instance or using any functionality
  ///
  /// Example:
  /// ```dart
  /// final navigatorKey = GlobalKey<NavigatorState>();
  ///
  /// await FlutterDino.initialize(
  ///   config: FlutterDinoConfig(
  ///     navigatorKey: navigatorKey,
  ///     showNoInternetDialog: true,
  ///   ),
  /// );
  /// ```
  static Future<void> initialize({
    required FlutterDinoConfig config,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();
    DialogServices.initialize(config);
    _instance = FlutterDino._(config);
    // await _instance!._checkInitialConnectivity();
    _instance!._checkInitialConnectivity();
  }

  FlutterDino._(this._config) {
    _initializeConnectivityStream();
  }

  void _checkInitialConnectivity() async {
    final connectivity = await Connectivity().checkConnectivity();
    _handleConnectivityChange(connectivity);
  }

  void _initializeConnectivityStream() {
    _connectivityStream = Connectivity().onConnectivityChanged.listen(
          _handleConnectivityChange,
        );
  }

  void _handleConnectivityChange(List<ConnectivityResult> result) {
    final hasNoInternet = result.contains(ConnectivityResult.none);

    if (hasNoInternet && !_isHavingInternet) {
      return; // Already showing no internet
    }
    if (!hasNoInternet && _isHavingInternet) {
      return; // Already showing has internet
    }

    _isHavingInternet = !hasNoInternet;

    if (!_isHavingInternet && _config.showNoInternetDialog) {
      DialogServices.instance.showNoInternetDialog();
    } else {
      DialogServices.instance.hideDialog();
    }
  }

  /// Disposes of the FlutterDino instance and cleans up resources
  Future<void> dispose() async {
    await _connectivityStream.cancel();
    DialogServices.instance.hideDialog();
    _instance = null;
  }
}

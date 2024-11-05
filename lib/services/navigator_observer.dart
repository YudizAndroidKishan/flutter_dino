import 'package:flutter/material.dart';

class DinoNavigatorObserver extends NavigatorObserver {
  final VoidCallback onNavigationComplete;

  DinoNavigatorObserver({
    required this.onNavigationComplete,
  });

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    super.didRemove(route, previousRoute);
    onNavigationComplete();
  }
}

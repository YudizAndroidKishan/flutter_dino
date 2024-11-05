import 'dart:developer';

import 'package:example/main.dart';
import 'package:flutter/material.dart';

class FlutterDinoSplash extends StatefulWidget {
  const FlutterDinoSplash({super.key});

  @override
  State<FlutterDinoSplash> createState() => _FlutterDinoSplashState();
}

class _FlutterDinoSplashState extends State<FlutterDinoSplash> {
  @override
  void initState() {
    log("Splash screen Init");
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
          (route) => false,
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Flutter dino Splash"),
      ),
    );
  }
}

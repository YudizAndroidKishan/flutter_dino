import 'package:flutter/material.dart';
import 'package:flutter_dino/flutter_dino.dart';

Future<void> main() async {
  final navigatorKey = GlobalKey<NavigatorState>();

  WidgetsFlutterBinding.ensureInitialized();
  // Initialize FlutterDino
  await FlutterDino.initialize(
    config: FlutterDinoConfig(
      navigatorKey: navigatorKey,
    ),
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff202123),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white38,
            fontSize: 35,
            fontWeight: FontWeight.w700,
          ),
          bodySmall: TextStyle(
            fontSize: 16,
            color: Colors.white38,
          ),
        ),
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w700,
          ),
          bodySmall: TextStyle(
            fontSize: 16,
          ),
        ),
      ),

      themeMode: ThemeMode.system,
      navigatorKey: navigatorKey, // Use the same navigatorKey here
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const Center(
        child: Text("I am having internet"),
      ),
    );
  }
}

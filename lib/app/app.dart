import 'package:flutter/material.dart';
import 'package:todo/presentation/resources/routes_manager.dart';

/// The main entry point for the application.
/// This is a singleton implementation of the `MyApp` widget, ensuring that only
/// one instance of the application is created. The `_MyAppState` handles the
/// widget's lifecycle and returns a `MaterialApp` with specific configurations.

class MyApp extends StatefulWidget {
  const MyApp._internal();

  // Singleton instance of MyApp
  static const MyApp instance = MyApp._internal();

  // Factory constructor to provide the singleton instance
  factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // MaterialApp with specific configurations
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.home,
    );
  }
}

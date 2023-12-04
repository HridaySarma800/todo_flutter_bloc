import 'package:flutter/material.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/presentation/resources/strings_manager.dart';
import 'package:todo/presentation/screens/home_screen.dart';
import 'package:todo/presentation/screens/task_screen.dart';

/// Class containing string constants for route names used in the application.
class Routes {
  /// Route name for the home screen.
  static const String home = '/home';

  /// Route name for the task screen.
  static const String addTask = '/task';
}

/// Class responsible for generating routes based on route settings.
class RouteGenerator {
  /// Generates and returns a dynamic route based on the provided [RouteSettings].
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.addTask:
        final task = routeSettings.arguments as TaskModel?;
        return MaterialPageRoute(builder: (_) => TaskScreen(task: task));
      // Default route for handling undefined routes.
      default:
        return unDefinedRoute();
    }
  }

  /// Generates and returns a route for handling undefined routes.
  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(StringsManager.noRouteFound),
        ),
        body: const Center(
          child: Text(StringsManager.noRouteFound),
        ),
      ),
    );
  }
}

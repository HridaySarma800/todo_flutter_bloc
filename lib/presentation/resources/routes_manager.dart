import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/presentation/resources/strings_manager.dart';
import 'package:todo/presentation/screens/home_screen.dart';
import 'package:todo/presentation/screens/task_screen.dart';

class Routes {
  static const String home = '/home';
  static const String addTask = '/task';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.addTask:
        final task = routeSettings.arguments as TaskModel?;
        return MaterialPageRoute(builder: (_) => TaskScreen(task: task));
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }

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

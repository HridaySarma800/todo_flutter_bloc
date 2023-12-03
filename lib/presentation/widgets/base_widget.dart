import 'package:flutter/material.dart';
import 'package:todo/data/impl/datat_repo_impl.dart';
import 'package:todo/presentation/resources/strings_manager.dart';

class BaseWidget extends InheritedWidget {
  BaseWidget({super.key, required super.child});

  final DataRepoImpl dataStore = DataRepoImpl();

  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError(StringsManager.stateError);
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

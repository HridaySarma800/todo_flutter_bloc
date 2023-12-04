import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/app/app.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/logic/dropdown/dropdown_cubit.dart';
import 'package:todo/logic/home_cubit/home_cubit.dart';
import 'package:todo/logic/task/task_cubit.dart';
import 'package:todo/logic/time/time_cubit.dart';
import 'package:todo/presentation/resources/strings_manager.dart';

Future<void> main() async {
  // Initialize Hive for Flutter, enabling the usage of Hive database.
  await Hive.initFlutter();
  // Register a custom adapter for the TaskModel class to facilitate
  // the serialization and deserialization of TaskModel instances.
  Hive.registerAdapter<TaskModel>(TaskModelAdapter());

  // Configure the application's state management using the MultiBlocProvider widget,
  // providing instances of HomeCubit, TimeCubit, TaskCubit, and DropdownCubit to manage
  // the state for different parts of the application.
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => HomeCubit(),
      ),
      BlocProvider(
        create: (context) => TimeCubit(),
      ),
      BlocProvider(
        create: (context) => TaskCubit(),
      ),
      BlocProvider(
        create: (context) => DropdownCubit(),
      ),
    ],
    child: MyApp(),
  ));
}

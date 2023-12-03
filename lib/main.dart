import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/app/app.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/logic/home_cubit/home_cubit.dart';
import 'package:todo/logic/task/task_cubit.dart';
import 'package:todo/logic/time/time_cubit.dart';
import 'package:todo/presentation/resources/strings_manager.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<TaskModel>(TaskModelAdapter());
  var box = await Hive.openBox<TaskModel>(StringsManager.boxName);

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
    ],
    child: MyApp(),
  ));
}

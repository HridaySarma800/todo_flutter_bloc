import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/impl/datat_repo_impl.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/logic/home_cubit/home_cubit.dart';
import 'package:todo/presentation/utils/globals.dart';

part 'task_state.dart';

/// Cubit responsible for managing the state of tasks.
/// The `TaskCubit` extends the `Cubit` class and provides methods for adding,
/// updating, and deleting tasks.
class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial()) {
    dataRepoImpl = DataRepoImpl();
  }

  late DataRepoImpl dataRepoImpl;

  /// Adds a new task with the provided title, subtitle, time, and date.
  /// After adding the task, it reloads all tasks on the home screen.
  /// If title or subtitle is null, it shows a warning.
  dynamic add(String? title, String? subtitle, DateTime? time, DateTime? date,
      BuildContext? context) {
    if (title != null && subtitle != null) {
      var task = TaskModel.create(
        title: title,
        createdAtTime: time,
        createdAtDate: date,
        subtitle: subtitle,
      );
      dataRepoImpl.addTask(task: task);
      if (context != null) {
        BlocProvider.of<HomeCubit>(context).loadAllTasks();
        Navigator.of(context).pop();
      }
    } else {
      emptyFieldsWarning(context);
    }
  }

  /// Updates the provided task with the new title, subtitle, time, and date.
  /// After updating the task, it reloads all tasks on the home screen.
  /// If title or subtitle is null, it shows a warning.
  update(String? title, String? subtitle, TaskModel? task, DateTime? time,
      DateTime? date, BuildContext? context) {
    if (title != null && subtitle != null) {
      task!.title = title;
      task.subtitle = subtitle;
      task.createdAtDate = date ?? DateTime.now();
      task.createdAtTime = time ?? DateTime.now();
      dataRepoImpl.updateTask(task: task);
      if (context != null) {
        BlocProvider.of<HomeCubit>(context).loadAllTasks();
        Navigator.of(context).pop();
      }
    } else {
      emptyFieldsWarning(context);
    }
  }

  /// Deletes the provided task from the data repository.
  dynamic deleteTask(TaskModel? taskModel) {
    if (taskModel != null) {
      dataRepoImpl.deleteTask(task: taskModel);
    }
  }
}

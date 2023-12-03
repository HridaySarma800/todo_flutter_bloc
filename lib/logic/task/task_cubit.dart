import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/impl/datat_repo_impl.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/logic/home_cubit/home_cubit.dart';
import 'package:todo/presentation/utils/constants.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial()) {
    dataRepoImpl = DataRepoImpl();
  }

  late DataRepoImpl dataRepoImpl;

  dynamic add(String? title, String? subtitle, DateTime? time, DateTime? date,
      BuildContext context) {
    if (title != null && subtitle != null) {
      var task = TaskModel.create(
        title: title,
        createdAtTime: time,
        createdAtDate: date,
        subtitle: subtitle,
      );
      dataRepoImpl.addTask(task: task);
      BlocProvider.of<HomeCubit>(context).loadAllTasks();
      Navigator.of(context).pop();
    } else {
      emptyFieldsWarning(context);
    }
  }

  update(String? title, String? subtitle, TaskModel? task, DateTime? time,
      DateTime? date, BuildContext context) {
    if (title != null && subtitle != null) {
      task!.title = title;
      task.subtitle = subtitle;
      task.createdAtDate = date ?? DateTime.now();
      task.createdAtTime = time ?? DateTime.now();
      dataRepoImpl.updateTask(task: task);
      BlocProvider.of<HomeCubit>(context).loadAllTasks();
      Navigator.of(context).pop();
    } else {
      emptyFieldsWarning(context);
    }
  }

  dynamic deleteTask(TaskModel? taskModel) {
    if (taskModel != null) {
      dataRepoImpl.deleteTask(task: taskModel);
    }
  }
}

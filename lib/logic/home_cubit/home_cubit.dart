import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/impl/datat_repo_impl.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/logic/task/task_cubit.dart';
import 'package:todo/presentation/utils/globals.dart';

part 'home_state.dart';

/// Cubit responsible for managing the state of the home screen.
/// The `HomeCubit` extends the `Cubit` class and provides methods for loading
/// tasks, filtering tasks based on completion status, canceling task deletion,
/// and handling task deletion with an undo option.

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial(random: Random().nextInt(999999))) {
    dataRepoImpl = DataRepoImpl();
    timer = Timer(Duration.zero, () {});
    loadAllTasks();
  }

  late DataRepoImpl dataRepoImpl;
  late Timer timer;
  bool deleteTask = true;
  late TaskModel? taskModel;
  int deleteCount = 0;

  /// Loads all tasks and emits the appropriate state.
  void loadAllTasks() async {
    try {
      List<TaskModel> tasks = await dataRepoImpl.listAllTasks();
      if (tasks.isNotEmpty) {
        emit(HomeTasksLoaded(tasks: tasks, random: Random().nextInt(999999)));
      } else {
        emit(HomeTaskEmpty());
      }
    } catch (e) {
      emit(HomeTaskLoadFailed(e.toString()));
    }
  }

  /// Filters tasks based on the selected position.
  void filter(int pos) async {
    if (pos == 0) {
      loadAllTasks();
    } else if (pos == 1) {
      List<TaskModel> tasks = await dataRepoImpl.listAllTasks();
      List<TaskModel> filteredList = [];
      for (int i = 0; i < tasks.length; i++) {
        if (tasks[i].isCompleted) {
          filteredList.add(tasks[i]);
        }
      }
      if (filteredList.isNotEmpty) {
        emit(HomeTasksLoaded(
            tasks: filteredList, random: Random().nextInt(999999)));
      } else {
        emit(HomeTaskEmpty());
      }
    } else {
      List<TaskModel> tasks = await dataRepoImpl.listAllTasks();
      List<TaskModel> filteredList = [];
      for (int i = 0; i < tasks.length; i++) {
        if (!tasks[i].isCompleted &&
            isPending(tasks[i].createdAtDate, tasks[i].createdAtTime)) {
          filteredList.add(tasks[i]);
        }
      }
      if (filteredList.isNotEmpty) {
        emit(HomeTasksLoaded(
            tasks: filteredList, random: Random().nextInt(999999)));
      } else {
        emit(HomeTaskEmpty());
      }
    }
  }

  /// Cancels the task deletion and reloads all tasks.
  void cancelDelete() {
    deleteTask = false;
    loadAllTasks();
  }

  /// Deletes a task and handles undo functionality.
  void delete(TaskModel task, BuildContext context) {
    if (deleteTask) {
      BlocProvider.of<TaskCubit>(context).deleteTask(task);
      deleteTask = true;
      deleteCount--;
      if (deleteCount == 0) {
        loadAllTasks();
      }
    } else {
      loadAllTasks();
    }
  }

  /// Updates the delete count for tracking multiple deletions.
  void updateDeleteCount() {
    deleteCount++;
  }
}

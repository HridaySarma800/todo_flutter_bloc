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
        if (!tasks[i].isCompleted && isPending(tasks[i].createdAtDate, tasks[i].createdAtTime)) {
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

  void cancelDelete() {
    deleteTask = false;
    loadAllTasks();
  }

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

  void updateDeleteCount() {
    deleteCount++;
  }
}

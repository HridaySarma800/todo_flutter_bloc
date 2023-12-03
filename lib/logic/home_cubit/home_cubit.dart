import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/impl/datat_repo_impl.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/logic/task/task_cubit.dart';

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

  void cancelDelete() {
    deleteTask = false;
    loadAllTasks();
  }

  void delete(TaskModel task, BuildContext context) {
    if (deleteTask) {
      BlocProvider.of<TaskCubit>(context).deleteTask(task);
      loadAllTasks();
      deleteTask = true;
    } else {
      loadAllTasks();
    }
  }
}

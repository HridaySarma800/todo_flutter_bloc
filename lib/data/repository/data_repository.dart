import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/data/models/task_model.dart';

abstract class DataRepository{
  Future<void> addTask({required TaskModel task});

  /// Show task
  Future<TaskModel?> getTask({required String id}) ;

  /// Update task
  Future<void> updateTask({required TaskModel task});

  /// Delete task
  Future<void> deleteTask({required TaskModel task});


  Future<List<TaskModel>> listAllTasks();
}
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/data/repository/data_repository.dart';
import 'package:todo/presentation/resources/strings_manager.dart';

class DataRepoImpl implements DataRepository {
  final Box<TaskModel> box = Hive.box<TaskModel>(StringsManager.boxName);

  @override
  Future<void> addTask({required TaskModel task}) async {
    await box.put(task.id, task);
  }

  @override
  Future<void> deleteTask({required TaskModel task}) async {
    await task.delete();
  }

  @override
  Future<TaskModel?> getTask({required String id}) async {
    return box.get(id);
  }

  @override
  Future<void> updateTask({required TaskModel task}) async {
    await task.save();
  }

  @override
  Future<List<TaskModel>> listAllTasks() async {
    return box.values.toList();
  }
}

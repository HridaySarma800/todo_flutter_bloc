import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/data/impl/datat_repo_impl.dart';
import 'package:todo/data/models/task_model.dart';

part 'task_test_state.dart';

class TaskTestCubit extends Cubit<TaskTestState> {
  TaskTestCubit() : super(TaskTestInitial());
  late DataRepoImpl dataRepoImpl;

  void add(
    String? title,
    String? subtitle,
    DateTime? time,
    DateTime? date,
  ) async {
    if (title != null && subtitle != null) {
      var task = TaskModel.create(
        title: title,
        createdAtTime: time,
        createdAtDate: date,
        subtitle: subtitle,
      );

      dataRepoImpl.addTask(task: task);
      if (await dataRepoImpl.getTask(id: task.id) != null) {
        emit(TaskTestAdded());
      } else {
        emit(TaskTestFailed());
      }
    } else {
      emit(TaskTestFailed());
    }
  }

  void update(String? title, String? subtitle, TaskModel? task,
      DateTime? time, DateTime? date) async {
    if (title != null && subtitle != null && date != null && time != null) {
      task!.title = title;
      task.subtitle = subtitle;
      task.createdAtDate = date;
      task.createdAtTime = time;
      dataRepoImpl.updateTask(task: task);
      TaskModel? model = await dataRepoImpl.getTask(id: task.id);
      if (model != null && model == task) {
        emit(TaskTestUpdated());
      } else {
        emit(TaskTestFailed());
      }
    } else {
      emit(TaskTestFailed());
    }
  }

  /// Deletes the provided task from the data repository.
  void deleteTask(TaskModel? taskModel) async {
    try {
      if (taskModel != null) {
        dataRepoImpl.deleteTask(task: taskModel);
        TaskModel? model = await dataRepoImpl.getTask(id: taskModel.id);
        if (model == null) {
          emit(TaskTestDeleted());
        } else {
          emit(TaskTestFailed());
        }
      } else {
        emit(TaskTestFailed());
      }
    } catch (e) {
      emit(TaskTestFailed());
    }
  }
}

import 'package:intl/intl.dart';
import 'package:todo/data/models/task_model.dart';

int checkDoneTask(List<TaskModel> task) {
  int i = 0;
  for (TaskModel doneTasks in task) {
    if (doneTasks.isCompleted) {
      i++;
    }
  }
  return i;
}

dynamic valueOfTheIndicator(List<TaskModel> task) {
  if (task.isNotEmpty) {
    return task.length;
  } else {
    return 3;
  }
}

bool tasksExists(TaskModel? taskModel) {
  if (taskModel != null) {
    return true;
  } else {
    return false;
  }
}

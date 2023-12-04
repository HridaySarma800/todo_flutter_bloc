import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/presentation/resources/strings_manager.dart';
import 'package:todo/presentation/resources/values_manager.dart';

/// Checks the number of completed tasks in the given list of tasks.
int checkDoneTask(List<TaskModel> task) {
  int i = 0;
  for (TaskModel doneTasks in task) {
    if (doneTasks.isCompleted) {
      i++;
    }
  }
  return i;
}

/// Returns the value for the indicator based on the list of tasks.
/// If the list is not empty, it returns the length of the list; otherwise, it returns a default value of 3.
dynamic valueOfTheIndicator(List<TaskModel> task) {
  if (task.isNotEmpty) {
    return task.length;
  } else {
    return 3;
  }
}

/// Checks if a task is pending based on its creation date and time.
bool isPending(DateTime createdAtDate, DateTime createdAtTime) {
  if (DateTime.now().isAfter(createdAtDate)) {
    return true;
  } else if (DateTime.now().day == createdAtDate.day &&
      DateTime.now().month == createdAtDate.month &&
      DateTime.now().year == createdAtDate.year &&
      DateTime.now().isAfter(createdAtTime)) {
    return true;
  } else {
    return false;
  }
}

/// Checks if a task exists.
bool tasksExists(TaskModel? taskModel) {
  if (taskModel != null) {
    return true;
  } else {
    return false;
  }
}

/// Displays a warning toast for empty fields.
emptyFieldsWarning(context) {
  return FToast.toast(
    context,
    msg: StringsManager.errorTitle,
    subMsg: StringsManager.mandatoryInfoText,
    corner: 20.0,
    duration: 2000,
    padding: const EdgeInsets.all(AppPadding.medium),
  );
}

/// Displays a toast message with the provided title and message.
showToast(context, String title, String message) {
  return FToast.toast(
    context,
    msg: title,
    subMsg: message,
    corner: 20.0,
    duration: 2000,
    padding: const EdgeInsets.all(AppPadding.medium),
  );
}

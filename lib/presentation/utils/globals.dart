import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:intl/intl.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/presentation/resources/strings_manager.dart';
import 'package:todo/presentation/resources/values_manager.dart';

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

bool tasksExists(TaskModel? taskModel) {
  if (taskModel != null) {
    return true;
  } else {
    return false;
  }
}

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

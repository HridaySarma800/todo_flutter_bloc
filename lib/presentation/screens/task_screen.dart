import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/logic/home_cubit/home_cubit.dart';
import 'package:todo/logic/task/task_cubit.dart';
import 'package:todo/presentation/resources/color_manager.dart';
import 'package:todo/presentation/resources/strings_manager.dart';
import 'package:todo/presentation/resources/styles_manager.dart';
import 'package:todo/presentation/resources/values_manager.dart';
import 'package:todo/presentation/utils/globals.dart';
import 'package:todo/presentation/widgets/task_app_bar.dart';

import '../../logic/time/time_cubit.dart';

/// The screen for creating or editing a task.
class TaskScreen extends StatefulWidget {
  const TaskScreen({
    super.key,
    required this.task,
  });

  /// The task to be edited. Null if creating a new task.
  final TaskModel? task;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  String? title;
  String? subtitle;
  DateTime? time;
  DateTime? date;

  late TextEditingController titleController;
  late TextEditingController subTitleController;

  @override
  void initState() {
    // Initialize state with task details if editing an existing task
    if (widget.task != null) {
      title = widget.task!.title;
      subtitle = widget.task!.subtitle;

      time = widget.task!.createdAtTime;
      date = widget.task!.createdAtDate;
    }
    titleController = TextEditingController(
        text: widget.task != null ? widget.task!.title : "");
    subTitleController = TextEditingController(
        text: widget.task != null ? widget.task!.subtitle : "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: TaskAppbar(
            taskModel: widget.task,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: AppSize.small,
                ),
                // Title Text Field
                Padding(
                  padding: const EdgeInsets.only(left: AppSize.small),
                  child: Text(StringsManager.titleOfTitleTextField,
                      style: headline1(color: Colors.black)),
                ),
                const SizedBox(
                  height: AppSize.small,
                ),
                // Title Input Field
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: AppMargin.medium),
                  child: TextFormField(
                    cursorHeight: AppSize.medium,
                    controller: titleController,
                    maxLines: 6,
                    style: headline3(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        label: Text(
                          StringsManager.writeTaskText,
                          style: subHeading(
                            color: Colors.black,
                          ),
                        )),
                    onFieldSubmitted: (value) {
                      title = value;
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onChanged: (value) {
                      title = value;
                      titleController.text = value;
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.medium,
                ),
                // Subtitle Input Field
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: subTitleController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.bookmark_border, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppSize.small,
                        ),
                      ),
                      label: Text(
                        StringsManager.addNote,
                        style: subHeading(
                          color: Colors.black,
                        ),
                      ),
                      counter: Container(),
                    ),
                    onFieldSubmitted: (value) {
                      subtitle = value;
                    },
                    onChanged: (value) {
                      subtitle = value;
                      subTitleController.text = value;
                    },
                  ),
                ),
                // Date and Time Pickers
                BlocBuilder<TimeCubit, TimeState>(
                  builder: (context, state) {
                    if (state is TimeInitial) {
                      return SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                DatePicker.showTimePicker(context,
                                    showTitleActions: true,
                                    showSecondsColumn: false,
                                    onChanged: (_) {},
                                    onConfirm: (selectedTime) {
                                  time = selectedTime;
                                  BlocProvider.of<TimeCubit>(context)
                                      .update(selectedTime, state.date);
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                    currentTime:
                                        BlocProvider.of<TimeCubit>(context)
                                            .showTimeAsDateTime(time));
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 10),
                                width: double.infinity,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(StringsManager.timeString,
                                          style:
                                              subHeading(color: Colors.black)),
                                    ),
                                    Expanded(child: Container()),
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      width: 80,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.shade100),
                                      child: Center(
                                        child: Text(
                                          BlocProvider.of<TimeCubit>(context)
                                              .showTime(state.time),
                                          style:
                                              subHeading(color: Colors.black),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime.now(),
                                    maxTime: DateTime(2030, 3, 5),
                                    onChanged: (_) {},
                                    onConfirm: (selectedDate) {
                                  date = selectedDate;
                                  BlocProvider.of<TimeCubit>(context)
                                      .update(state.time, selectedDate);
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                    currentTime:
                                        BlocProvider.of<TimeCubit>(context)
                                            .showDateAsDateTime(date));
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                width: double.infinity,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(StringsManager.dateString,
                                          style:
                                              subHeading(color: Colors.black)),
                                    ),
                                    Expanded(child: Container()),
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      width: 140,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.shade100),
                                      child: Center(
                                        child: Text(
                                          BlocProvider.of<TimeCubit>(context)
                                              .showDate(date),
                                          style:
                                              subHeading(color: Colors.black),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: tasksExists(widget.task)
                        ? MainAxisAlignment.spaceEvenly
                        : MainAxisAlignment.center,
                    children: [
                      // Delete Button (visible only when editing an existing task).
                      tasksExists(widget.task)
                          ? Container(
                              width: 150,
                              height: 55,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorManager.primary, width: 2),
                                  borderRadius: BorderRadius.circular(15)),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                minWidth: 150,
                                height: 55,
                                onPressed: () {
                                  BlocProvider.of<TaskCubit>(context)
                                      .deleteTask(widget.task);
                                  BlocProvider.of<HomeCubit>(context)
                                      .loadAllTasks();
                                  showToast(context, StringsManager.success,
                                      StringsManager.deletedMessage);
                                  Navigator.pop(context);
                                },
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.close,
                                      color: ColorManager.primary,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      StringsManager.deleteTaskText,
                                      style: TextStyle(
                                        color: ColorManager.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: AppSize.xl,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        minWidth: AppSize.xll,
                        height: 55,
                        onPressed: () {
                          // Check if creating a new task or updating an existing one
                          if (widget.task == null) {
                            BlocProvider.of<TaskCubit>(context)
                                .add(title, subtitle, time, date, context);
                          } else {
                            BlocProvider.of<TaskCubit>(context).update(title,
                                subtitle, widget.task, time, date, context);
                          }
                        },
                        color: ColorManager.primary,
                        child: Text(
                            tasksExists(widget.task)
                                ? StringsManager.updateTaskText
                                : StringsManager.addTaskButtonText,
                            style: subHeading(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

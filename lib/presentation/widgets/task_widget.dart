import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/logic/home_cubit/home_cubit.dart';
import 'package:todo/presentation/resources/color_manager.dart';
import '../resources/routes_manager.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key, required this.task});

  final TaskModel task;

  @override
  // ignore: library_private_types_in_public_api
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController taskControllerForTitle = TextEditingController();
  TextEditingController taskControllerForSubtitle = TextEditingController();

  @override
  void initState() {
    super.initState();
    taskControllerForTitle.text = widget.task.title;
    taskControllerForSubtitle.text = widget.task.subtitle;
  }

  @override
  void dispose() {
    taskControllerForTitle.dispose();
    taskControllerForSubtitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.addTask, arguments: widget.task);
      },

      /// Main Card
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: widget.task.isCompleted
                ? const Color.fromARGB(154, 119, 144, 229)
                : Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  offset: const Offset(0, 4),
                  blurRadius: 10)
            ]),
        child: ListTile(
            leading: GestureDetector(
              onTap: () {
                widget.task.isCompleted = !widget.task.isCompleted;
                widget.task.save();
                BlocProvider.of<HomeCubit>(context).loadAllTasks();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                decoration: BoxDecoration(
                    color: widget.task.isCompleted
                        ? ColorManager.primary
                        : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: .8)),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            ),

            /// title of Task
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 3),
              child: Text(
                taskControllerForTitle.text,
                style: TextStyle(
                    color: widget.task.isCompleted
                        ? ColorManager.primary
                        : Colors.black,
                    fontWeight: FontWeight.w500,
                    decoration: widget.task.isCompleted
                        ? TextDecoration.lineThrough
                        : null),
              ),
            ),

            /// Description of task
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskControllerForSubtitle.text,
                  style: TextStyle(
                    color: widget.task.isCompleted
                        ? ColorManager.primary
                        : const Color.fromARGB(255, 164, 164, 164),
                    fontWeight: FontWeight.w300,
                    decoration: widget.task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),

                /// Date & Time of Task
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                      top: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('hh:mm a')
                              .format(widget.task.createdAtTime),
                          style: TextStyle(
                              fontSize: 14,
                              color: widget.task.isCompleted
                                  ? Colors.white
                                  : Colors.grey),
                        ),
                        Text(
                          DateFormat.yMMMEd().format(widget.task.createdAtDate),
                          style: TextStyle(
                              fontSize: 12,
                              color: widget.task.isCompleted
                                  ? Colors.white
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/logic/home_cubit/home_cubit.dart';
import 'package:todo/presentation/resources/color_manager.dart';
import 'package:todo/presentation/resources/styles_manager.dart';
import 'package:todo/presentation/resources/values_manager.dart';
import 'package:todo/presentation/utils/globals.dart';
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
                ? Colors.green
                : isPending(
                        widget.task.createdAtDate, widget.task.createdAtTime)
                    ? Colors.yellow
                    : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black),
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
                duration: const Duration(seconds: 2),
                decoration: BoxDecoration(
                    color: widget.task.isCompleted
                        ? ColorManager.primary
                        : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: .8)),
                child: Padding(
                  padding: const EdgeInsets.all(AppSize.xxs),
                  child: isPending(widget.task.createdAtDate,
                              widget.task.createdAtTime) &&
                          !widget.task.isCompleted
                      ? const Icon(
                          Icons.pending_actions_sharp,
                          color: Colors.black87,
                          size: AppSize.semiMedium,
                        )
                      : const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: AppSize.semiMedium,
                        ),
                ),
              ),
            ),

            /// title of Task
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 3),
              child: Text(
                taskControllerForTitle.text,
                style: subHeading(
                  color: widget.task.isCompleted ? Colors.white : Colors.black,
                )?.copyWith(
                  decoration: widget.task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                  decorationThickness: 0.9,

                ),
              ),
            ),

            /// Description of task
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskControllerForSubtitle.text,
                  style: body(
                    color:
                        widget.task.isCompleted ? Colors.white : Colors.black54,
                  )?.copyWith(
                      decoration: widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : null),
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
                            style: body(
                                color: widget.task.isCompleted
                                    ? Colors.white
                                    : Colors.black45)),
                        Text(
                          DateFormat.yMMMEd().format(widget.task.createdAtDate),
                          style: caption(
                              color: widget.task.isCompleted
                                  ? Colors.white
                                  : Colors.black87),
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

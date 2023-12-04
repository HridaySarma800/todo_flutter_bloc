import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/presentation/resources/color_manager.dart';
import 'package:todo/presentation/resources/strings_manager.dart';
import 'package:todo/presentation/resources/styles_manager.dart';
import 'package:todo/presentation/resources/values_manager.dart';
import 'package:todo/presentation/utils/globals.dart';
// App bar in the task screen
class TaskAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TaskAppbar({super.key, required this.taskModel});

  final TaskModel? taskModel;


  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: AppSize.xs,
      shadowColor: Colors.grey,
      child: Container(
        height: AppSize.large,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle, color: ColorManager.primary),
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: AppSize.semiMedium,
                    color: Colors.white,
                  ),
                ),
                RichText(
                  text: TextSpan(
                      text: tasksExists(taskModel)
                          ? StringsManager.updateTaskText
                          : StringsManager.addTaskText,
                      style: headline2(color: Colors.white),
                      children: [
                        TextSpan(
                            text: StringsManager.taskText,
                            style: headline2(color: Colors.white))
                      ]),
                ),
                const SizedBox(
                  width: AppSize.small,
                ),
              ],
            )),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

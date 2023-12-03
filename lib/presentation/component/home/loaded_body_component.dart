import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/logic/home_cubit/home_cubit.dart';
import 'package:todo/presentation/resources/strings_manager.dart';
import 'package:todo/presentation/resources/styles_manager.dart';
import 'package:todo/presentation/utils/functions.dart';
import 'package:todo/presentation/widgets/task_widget.dart';
import '../../../data/models/task_model.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';

class LoadedBody extends StatelessWidget {
  const LoadedBody({super.key, required this.tasks});

  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(55, 0, 0, 0),
            width: double.infinity,
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(ColorManager.primary),
                    backgroundColor: Colors.grey,
                    value: checkDoneTask(tasks) / valueOfTheIndicator(tasks),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(StringsManager.mainTitle,
                        style: headline2(color: Colors.black)),
                    const SizedBox(
                      height: 3,
                    ),
                    Text("${checkDoneTask(tasks)} of ${tasks.length} task",
                        style: subHeading(color: Colors.black)),
                  ],
                )
              ],
            ),
          ),

          /// Divider
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 2,
              indent: 100,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 585,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                var task = tasks[index];
                return Dismissible(
                  direction: DismissDirection.horizontal,
                  resizeDuration: const Duration(seconds: 4),
                  movementDuration: const Duration(seconds: 4),
                  background: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.delete_outline,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(StringsManager.taskDeletedText,
                          style: subHeading(color: Colors.red)),
                      const SizedBox(
                        width: AppSize.small,
                      ),
                      InkWell(
                        onTap: () {
                          BlocProvider.of<HomeCubit>(context).cancelDelete();
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.refresh,
                              color: Colors.blue,
                            ),
                            Text(
                              "Undo",
                              style: subHeading(color: Colors.blue),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  onDismissed: (direction) {
                    BlocProvider.of<HomeCubit>(context).delete(task, context);
                  },
                  key: UniqueKey(),
                  child: TaskWidget(
                    task: tasks[index],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

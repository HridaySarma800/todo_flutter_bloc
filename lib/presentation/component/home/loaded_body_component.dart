import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/logic/dropdown/dropdown_cubit.dart';
import 'package:todo/logic/home_cubit/home_cubit.dart';
import 'package:todo/presentation/models/menu_item.dart';
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
            height: AppSize.large,
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
                    Text(
                        "${checkDoneTask(tasks)} of ${tasks.length} task${tasks.length > 1 ? 's' : ''} completed !",
                        style: subHeading(color: Colors.black)),
                  ],
                ),
                const SizedBox(
                  width: AppSize.medium,
                ),
                SizedBox(
                  width: AppSize.large,
                  height: AppSize.large,
                  child: BlocBuilder<DropdownCubit, DropdownState>(
                    builder: (context, state) {
                      if (state is DropdownInitial) {
                        return const CircularProgressIndicator();
                      } else if (state is DropdownItemsLoaded) {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            customButton: const SizedBox(
                              height: AppSize.small,
                              width: AppSize.small,
                              child: Card(
                                child: Icon(
                                  Icons.filter_list,
                                  size: AppSize.semiMedium,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            items: [
                              ...state.items.map(
                                (item) => DropdownMenuItem<MenuItem>(
                                    value: item,
                                    child: Row(
                                      children: [
                                        Icon(item.icon,
                                            color: item ==
                                                    state.items[state.selected]
                                                ? Colors.greenAccent
                                                : Colors.white,
                                            size: AppSize.semiMedium),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(item.text,
                                              style: body(
                                                color: item ==
                                                        state.items[
                                                            state.selected]
                                                    ? Colors.greenAccent
                                                    : Colors.white,
                                              )),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                            onChanged: (value) {
                              BlocProvider.of<DropdownCubit>(context).toggle(
                                  state.items.indexOf(value!), state.items);
                              BlocProvider.of<HomeCubit>(context)
                                  .filter(state.items.indexOf(value));
                            },
                            dropdownStyleData: DropdownStyleData(
                              width: AppSize.xl,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.grey,
                              ),
                            ),
                            menuItemStyleData: MenuItemStyleData(
                              customHeights: [
                                ...List<double>.filled(state.items.length, 48),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
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
                bool first = true;
                return Dismissible(
                  direction: DismissDirection.horizontal,
                  resizeDuration: const Duration(seconds: 2),
                  movementDuration: const Duration(seconds: 2),
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
                  onUpdate: (e) {
                    if (e.progress > 0 && first) {
                      first = false;
                      BlocProvider.of<HomeCubit>(context).updateDeleteCount();
                    }
                  },
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

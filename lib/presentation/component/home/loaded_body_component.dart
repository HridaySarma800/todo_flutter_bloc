import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/logic/dropdown/dropdown_cubit.dart';
import 'package:todo/logic/home_cubit/home_cubit.dart';
import 'package:todo/presentation/models/menu_item.dart';
import 'package:todo/presentation/resources/strings_manager.dart';
import 'package:todo/presentation/resources/styles_manager.dart';
import 'package:todo/presentation/utils/globals.dart';
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
          // Progress Indicator and Title
          Container(
            margin: const EdgeInsets.symmetric(
                vertical: AppSize.medium, horizontal: AppSize.small),
            width: double.infinity,
            height: AppSize.large,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Circular Progress Indicator
                SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(ColorManager.primary),
                    backgroundColor: Colors.grey,
                    value: checkDoneTask(tasks) / valueOfTheIndicator(tasks),
                  ),
                ),
                // Title Section
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Title
                    Text(StringsManager.mainTitle,
                        style: headline3(color: Colors.black)),
                    const SizedBox(
                      height: 3,
                    ),
                    // Task Completion Status
                    Text(
                        "${checkDoneTask(tasks)} of ${tasks.length} task${tasks.length > 1 ? 's' : ''} completed !",
                        style: subHeading(color: Colors.black)),
                  ],
                ),
                // Dropdown for Task Filtering
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
                            // Dropdown items based on the loaded items from the state
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
                                        // Text representing the filter item
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
                            // Callback when a dropdown item is selected
                            onChanged: (value) {
                              BlocProvider.of<DropdownCubit>(context).toggle(
                                  state.items.indexOf(value!), state.items);
                              BlocProvider.of<HomeCubit>(context)
                                  .filter(state.items.indexOf(value));
                            },
                            // Styling for the dropdown and menu items
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
                        // Return an empty SizedBox if the dropdown state is not recognized
                        return const SizedBox();
                      }
                    },
                  ),
                )
              ],
            ),
          ),

          // Divider
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 2,
              indent: 100,
            ),
          ),
          // Task List
          SizedBox(
            width: double.infinity,
            height: 585,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                var task = tasks[index];
                bool first = true;
                // Dismissible Task Widget
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

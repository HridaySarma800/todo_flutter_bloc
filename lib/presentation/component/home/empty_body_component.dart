import 'package:animate_do/animate_do.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/logic/dropdown/dropdown_cubit.dart';
import 'package:todo/presentation/models/menu_item.dart';
import 'package:todo/presentation/resources/assets_manager.dart';
import 'package:todo/presentation/resources/color_manager.dart';
import 'package:todo/presentation/resources/strings_manager.dart';
import 'package:todo/presentation/resources/styles_manager.dart';
import 'package:todo/presentation/resources/values_manager.dart';

import '../../../logic/home_cubit/home_cubit.dart';

class EmptyBody extends StatelessWidget {
  const EmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Loading Indicator and Title
        Container(
          margin: const EdgeInsets.symmetric(
              vertical: AppSize.medium, horizontal: AppSize.small),
          height: AppSize.large,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Loading Indicator
              SizedBox(
                width: AppSize.medium,
                height: AppSize.medium,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(ColorManager.primary),
                  backgroundColor: Colors.grey,
                  value: 1,
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
                  Text("0 of 0 task completed !",
                      style: subHeading(color: Colors.black)),
                ],
              ),
              // Dropdown for Task Filtering
              BlocBuilder<DropdownCubit, DropdownState>(
                builder: (context, state) {
                  if (state is DropdownInitial) {
                    // Display a loading indicator for dropdown initialization.
                    return const CircularProgressIndicator();
                  } else if (state is DropdownItemsLoaded) {
                    // Display the actual dropdown when items are loaded.
                    return DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        // Custom button with filter icon
                        customButton: const SizedBox(
                          height: AppSize.semiLarge,
                          width: AppSize.semiLarge,
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
                                    // Icon representing the filter item
                                    Icon(item.icon,
                                        color:
                                            item == state.items[state.selected]
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
                                                    state.items[state.selected]
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
                          // Toggle dropdown selection and apply filter
                          BlocProvider.of<DropdownCubit>(context)
                              .toggle(state.items.indexOf(value!), state.items);
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
                    // Return an empty SizedBox if the dropdown state is not recognized.
                    return const SizedBox();
                  }
                },
              )
            ],
          ),
        ),
        // Divider
        const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Divider(
            thickness: 2,
            indent: AppSize.large,
          ),
        ),
        // Lottie Animation and Bottom Text
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie Animation
            FadeIn(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Lottie.asset(
                  AssetManager.lottieURL,
                  animate: true,
                ),
              ),
            ),

            // Bottom Text
            FadeInUp(
              from: 30,
              child: const Text(StringsManager.allTasksCompletedText),
            ),
          ],
        ),
      ],
    );
  }
}

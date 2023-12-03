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
        Container(
          margin: const EdgeInsets.fromLTRB(55, 0, 0, 0),
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
                  value: 1,
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
                  Text("0 of 0 task completed !", style: subHeading(color: Colors.black)),

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
                                              state
                                                  .items[state.selected]
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
                              ...List<double>.filled(
                                  state.items.length, 48),
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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Lottie
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

            /// Bottom Texts
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

import 'package:flutter/material.dart';
import 'package:todo/presentation/resources/color_manager.dart';
import 'package:todo/presentation/resources/routes_manager.dart';

import '../resources/values_manager.dart';


// A floating action button to add tasks.
class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.addTask);
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: Container(
          width: AppSize.large,
          height: AppSize.large,
          decoration: BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadius.circular(AppSize.small),
          ),
          child: const Center(
              child: Icon(
            Icons.add,
            color: Colors.white,
                size: AppSize.medium,
          )),
        ),
      ),
    );
  }
}

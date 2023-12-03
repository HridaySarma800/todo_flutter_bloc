import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/presentation/resources/assets_manager.dart';

import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/styles_manager.dart';

class ErrorBody extends StatelessWidget {
  const ErrorBody({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  value: 0 / 0,
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
                  Text("0 of 0 task", style: subHeading(color: Colors.black)),
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

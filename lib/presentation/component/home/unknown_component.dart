import 'package:flutter/material.dart';
import 'package:todo/presentation/resources/strings_manager.dart';
import 'package:todo/presentation/resources/styles_manager.dart';

class UnknownBody extends StatelessWidget {
  const UnknownBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Text(
          StringsManager.errorTitle,
          style: headline2(color: Colors.red),
        ),
      ),
    );
  }
}

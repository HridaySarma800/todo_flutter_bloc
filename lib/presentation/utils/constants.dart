import 'package:flutter/cupertino.dart';
import 'package:ftoast/ftoast.dart';
import 'package:todo/presentation/resources/strings_manager.dart';
import 'package:todo/presentation/resources/values_manager.dart';

emptyFieldsWarning(context) {
  return FToast.toast(
    context,
    msg: StringsManager.errorTitle,
    subMsg: StringsManager.mandatoryInfoText,
    corner: 20.0,
    duration: 2000,
    padding: const EdgeInsets.all(AppPadding.medium),
  );
}




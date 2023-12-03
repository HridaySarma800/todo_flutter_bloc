
import 'package:flutter/cupertino.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:todo/presentation/resources/strings_manager.dart';

/// No task Warning Dialog
dynamic warningNoTask(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(
    context,
    title: StringsManager.errorTitle,
    message:
    StringsManager.errorMessage,
    buttonText: "Okay",
    onTapDismiss: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.warning,
  );
}

/// Delete All Task Dialog
dynamic deleteAllTask(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    title: StringsManager.confirmationTitle,
    message:
    StringsManager.confirmationMessage,
    confirmButtonText: StringsManager.yesText,
    cancelButtonText: StringsManager.noText,
    onTapCancel: () {
      Navigator.pop(context);
    },
    onTapConfirm: () {
      // BaseWidget.of(context).dataStore.box.clear();
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false,
  );
}
import 'package:flutter/material.dart';

import '../main.dart';

Future BottomDialog({
  required Widget child,
  required String title,
  bool barrierDismissible = true,
  double? width,
  bool isError = false,
  bool showCancelButton = true,
}) async {
  return await showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 700),
    context: appContext,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: child
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}

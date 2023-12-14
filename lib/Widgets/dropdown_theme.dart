import 'package:flutter/material.dart';

import '../main.dart';
import '../theme/app_color.dart';

Widget DropdownTheme({required Widget child}){
  return Theme(
    data: ThemeData(
        colorScheme: const ColorScheme.light().copyWith(
          primary: AppColor.primary,
        ),
        textTheme: TextTheme(
          subtitle1: appTheme().textTheme.bodyLarge,
        )
    ),
    child: child
  );
}
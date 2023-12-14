import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../main.dart';

Widget EmptyView({String? message,String? actionMessage, double? height,GestureTapCallback? action}) {
  return SizedBox(
    width: 1.sw,
    height: height ?? 1.sh,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(message ?? '${appLanguage().noDataHere}!',style: appTheme().textTheme.headlineLarge!.copyWith(
          color: const Color(0xff465471),
        ),)
      ],
    ),
  );
}

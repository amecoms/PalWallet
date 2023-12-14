import 'package:flutter/material.dart';
import '../theme/app_color.dart';


Widget CircularShape({required double size,Color? color,Widget? child}) {
  return Container(
    height: size,
    width: size,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: color ?? AppColor.grey.withOpacity(0.5),
        shape: BoxShape.circle
    ),
    child: child,
  );
}
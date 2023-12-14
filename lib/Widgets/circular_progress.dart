import 'package:flutter/material.dart';
import '../theme/app_color.dart';

Widget CircularProgress({double? height,double size = 20, Color? color, double width = 2, Alignment alignment=Alignment.center}) {
  return Container(
    height: height,
    alignment: alignment,
    child: SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
          strokeWidth: width,
          valueColor: AlwaysStoppedAnimation<Color>(
              color ?? AppColor.primary)),
    ),
  );
}

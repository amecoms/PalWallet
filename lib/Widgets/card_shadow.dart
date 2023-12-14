import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_color.dart';

Decoration CardShadow({double? borderRadius}){
  return BoxDecoration(
    color: AppColor.buttonTextColor,
    borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
    boxShadow: [
      BoxShadow(
        color: AppColor.shadowColor,
        blurRadius: 10.r,
        offset: const Offset(0.0,1),
      ),
    ],
  );
}
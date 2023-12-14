import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ButtonStyle DefaultButtonStyle(Color color,{double borderRadius=2,double? elevation, EdgeInsetsGeometry? padding}){
  return ElevatedButton.styleFrom(
    primary: color,
    minimumSize: Size.zero,
    elevation: elevation,
    padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.w),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius)
    )
  );
}
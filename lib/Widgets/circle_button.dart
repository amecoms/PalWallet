import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_color.dart';

Widget CircleButton({required bool loading,bool isEnable=true,Color? loadingColor,required Widget child,required Function onTap}){
  return Material(
    color: Colors.transparent,
    child: InkWell(
        onTap: () => isEnable && !loading ? onTap() : null,
        borderRadius: BorderRadius.circular(100.r),
        child: !loading ? child : Container(
          width: 20.h,
          height: 20.h,
          margin: EdgeInsets.all(8.r),
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(loadingColor ?? AppColor.primary),
            strokeWidth: 2,
          ),
        )
    ),
  );
}
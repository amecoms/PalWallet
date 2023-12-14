import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../gen/assets.gen.dart';
import '../main.dart';
import '../theme/app_color.dart';

AppBar DefaultAppbar ({String? title, Widget? titleWidget,bool returnData=false,List<Widget>? actions,Color? color,PreferredSizeWidget? bottom,bool centerTitle=true,bool haveLeading=true,double? elevation,VoidCallback? onBack,TextStyle? textStyle}){
  return AppBar(
    centerTitle: centerTitle,
    backgroundColor: color ?? Colors.transparent,
    automaticallyImplyLeading: false,
    elevation: elevation,
    titleSpacing: 6.w,
    leadingWidth: 44.w,
    title: titleWidget ?? Text(title ?? ''),
    flexibleSpace: Image(
      image: AssetImage(Assets.images.appbarBack.keyName),
      fit: BoxFit.cover,
    ),
    leading: haveLeading ? Container(
      margin: const EdgeInsets.only(left: 8).r,
      child: BackButton(
        color: AppColor.white,
        onPressed: onBack ?? (){
          navigatorKey.currentState!.pop();
        },
      ),
    ) : null,
    actions: actions,
    bottom: bottom,
  );
}

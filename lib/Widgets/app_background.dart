import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/connnectivity_helper.dart';
import '../gen/assets.gen.dart';
import '../main.dart';
import '../theme/app_color.dart';
import '../utils/dimension.dart';

Widget AppBackground({required Widget child,bool visibleWarning = true}){
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(Assets.images.spashScreen.keyName),
        fit: BoxFit.cover,
      ),
    ),
    child: Column(
      children: [
        Expanded(child: child),
        ValueListenableBuilder<ConnectivityResult>(
          valueListenable: ConnectivityHelper.networkState,
          builder: (context,value,child){
            return Visibility(
              visible: value == ConnectivityResult.none,
              child: Container(
                color: AppColor.red,
                width: 1.sw,
                padding: EdgeInsets.symmetric(vertical: 2.r,horizontal: 16.r),
                margin: EdgeInsets.only(bottom: Dimension.paddingBottom),
                child: Text(appLanguage(context).no_internet_connection,style: appTheme(context).textTheme.bodyMedium!.copyWith(color: AppColor.buttonTextColor,),textAlign: TextAlign.center,),
              ),
            );
          }
        )
      ],
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widgets/default_button.dart';
import '../Widgets/default_dialog.dart';
import '../Widgets/dialog_button.dart';
import '../main.dart';
import '../theme/app_color.dart';

Future MessageDialog({
  required String title,
  required String message,
  String? buttonName,
  Function(bool)? onTap,
  Color? buttonColor,
  bool isConfirmDialog = false
}) async {
  return await showDialog(
    context:appContext,
    builder:(context){
     return DefaultDialog(
       title: title,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(message,style: appTheme().textTheme.bodyLarge,),
            if (!isConfirmDialog) Container(
             margin: EdgeInsets.only(bottom: 10.r,top: 20.r),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.end,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 DefaultButton(
                     onTap: (){
                       if(onTap!=null) {
                          onTap(true);
                       } else {
                         backPage();
                       }
                     },
                     backgroundColor:buttonColor??AppColor.primary,
                     padding: EdgeInsets.all(16.r).copyWith(top: 12.r,bottom: 12.r),
                     child: Container(
                         constraints: BoxConstraints(
                             minWidth: 0.2.sw
                         ),
                         alignment: Alignment.center,
                         child: Text(buttonName ?? appLanguage().ok,style: appTheme().textTheme.headlineMedium!.copyWith(color: AppColor.buttonTextColor),)
                     )
                 ),
               ],
             ),
           ) else Container(
             margin: EdgeInsets.only(top: 20.r),
             child: DialogButton(
                  onTap: onTap!,
                  positiveButton: appLanguage(context).yes,
                  negativeButton: appLanguage(context).no
              ),
           ),
           10.verticalSpace
         ],
       ),
     );
    }
  );
}
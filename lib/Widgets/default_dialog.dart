import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widgets/dialog_button.dart';
import '../theme/app_color.dart';

import '../../main.dart';

class DefaultDialog extends StatefulWidget {
  Widget child;
  String? title;
  Widget? titleWidget;
  bool isError;
  Alignment alignment;
  EdgeInsetsGeometry? padding;
  double? width;
  bool enableCloseButton;
  bool barrierDismissible;
  bool enableHeading;
  Function(bool)? onButtonClick;
  String? negativeButtonTitle;
  String? positiveButtonTitle;
  Color? titleColor;

  DefaultDialog({required this.child,this.title,this.titleWidget,this.isError=false,this.alignment=Alignment.center,this.width,this.enableCloseButton=false,this.barrierDismissible=true,this.enableHeading=true,this.onButtonClick,this.negativeButtonTitle,this.positiveButtonTitle,this.titleColor,this.padding});
  @override
  _DefaultDialogState createState() => _DefaultDialogState(child: child,title: title ?? '',isError: isError);
}

class _DefaultDialogState extends State<DefaultDialog> {

  Widget child;
  String title;
  bool isError;
  double titleWidth=0.2.sw;

  _DefaultDialogState({required this.child,required this.title,this.isError=false});


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: back,
      child: AnimatedContainer(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 300),
        child: Align(
          alignment: widget.alignment,
          child: Material(
            color: AppColor.cardColor,
            borderRadius: BorderRadius.circular(5.r),
            clipBehavior: Clip.antiAlias,
            child: Card(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.all(0),
              elevation: 0,
              color: AppColor.cardColor,
              child: Container(
                width: widget.width ?? 0.9.sw,
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: AppColor.cardColor,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.enableHeading ? Container(
                        padding: EdgeInsets.only(left: 26.r,right: 26.r,top: 24.r,bottom: 16.r),
                        child: Row(
                          children: [
                            Expanded(child: widget.titleWidget ?? Text(title,style: appTheme(context).textTheme.headlineLarge!.copyWith(color: widget.titleColor ?? AppColor.textColor),)),
                            Visibility(
                                visible: widget.enableCloseButton,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: ()=>Navigator.pop(context),
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Container(
                                      height: 30.h,
                                      width: 30.h,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(8.r),
                                        border: Border.all(color: AppColor.grey,width: 1)
                                      ),
                                      child: Icon(Icons.close,color: AppColor.red,size: 18.r,),
                                    ),
                                  ),
                                )
                            )
                          ],
                        ),
                      ) : Container(height: 16.h,),
                      Padding(
                        padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 26.r),
                        child: child,
                      ),
                      Visibility(
                        visible: widget.onButtonClick!=null,
                        child: Container(
                          padding: EdgeInsets.all(16.r).copyWith(bottom: 0,top: 10.r),
                          child: DialogButton(
                            negativeButton: widget.negativeButtonTitle ?? appLanguage().no,
                            positiveButton: widget.positiveButtonTitle ?? appLanguage().yes,
                            onTap: (state)=>widget.onButtonClick!(state)
                          ),
                        )
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> back() {
    if(widget.barrierDismissible){
      Navigator.pop(context);
    }
    return Future.value(widget.barrierDismissible);
  }
}
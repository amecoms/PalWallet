import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widgets/circular_progress.dart';
import '../theme/app_color.dart';
import 'dynamic_sIze_widget.dart';

enum ButtonType {SOLID,BORDER}

class DefaultButton extends StatefulWidget {
  DefaultButton({
    required this.onTap,
    required this.child,
    this.backgroundColor,
    this.buttonType = ButtonType.SOLID,
    this.borderColor,
    this.disableColor,
    this.loadingColor,
    this.borderRadius = 8,
    this.enable = true,
    this.enableShadow=false,
    this.padding,
    this.isLoading=false,
    this.progressbarSize,
    super.key});

  VoidCallback onTap;
  Widget child;
  Color? backgroundColor;
  ButtonType buttonType = ButtonType.SOLID;
  Color? borderColor;
  Color? disableColor;
  Color? loadingColor;
  double? borderRadius;
  bool enable = true;
  bool enableShadow=false;
  EdgeInsetsGeometry? padding;
  bool isLoading=false;
  double? progressbarSize;

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> with AutomaticKeepAliveClientMixin{
  ValueNotifier<double> childHeight = ValueNotifier(10);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.enable ? (){
        if(!widget.isLoading) widget.onTap();
      } : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.enable ? (widget.buttonType == ButtonType.SOLID ? (widget.backgroundColor ?? AppColor.primary) : Colors.transparent) : AppColor.primary.withOpacity(0.25),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
            side: widget.buttonType == ButtonType.BORDER ? BorderSide(
                color: widget.borderColor ?? widget.backgroundColor ?? AppColor.primary,
                width: 2
            ) : BorderSide.none
        ),
        disabledBackgroundColor: !widget.enable ? widget.disableColor ?? AppColor.buttonDisableColor : Colors.transparent,
        padding: widget.padding ?? REdgeInsets.symmetric(horizontal: 16, vertical: 16).copyWith(top: widget.buttonType == ButtonType.BORDER ? 16.r-2 : 16.r,bottom: widget.buttonType == ButtonType.BORDER ? 16.r-2 : 16.r),
        alignment: Alignment.center,
        elevation: 0,
      ).copyWith(
        overlayColor: MaterialStatePropertyAll<Color>((widget.buttonType == ButtonType.SOLID ? (widget.backgroundColor ?? AppColor.primary) : Colors.transparent)),
      ),
      child: ValueListenableBuilder<double>(
        valueListenable: childHeight,
        builder: (ctx,value, ch){
          return DynamicSizeWidget(
            onGetSize: (height,width){
              if(childHeight.value < height){
                childHeight.value = height;
              }
            },
            child: widget.isLoading ? CircularProgress(color: widget.loadingColor ?? AppColor.background,size: widget.progressbarSize ?? value) : widget.child,
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

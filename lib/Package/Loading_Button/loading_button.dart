import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_color.dart';

enum ButtonDecoration{Shadow,Flat}
class LoadingButton extends StatefulWidget {
  final Widget child;
  final bool isLoading;
  final void Function() onPressed;
  final Color? backgroundColor;
  final BoxDecoration? decoration;
  final Widget? loadingWidget;
  final ButtonDecoration buttonDecoration;
  final double? radius;
  final paddingEnable;
  final bool? isEnable;

  const LoadingButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.decoration,
    this.loadingWidget,
    this.radius,
    this.buttonDecoration=ButtonDecoration.Flat,
    this.paddingEnable=true, this.isEnable=true
  }) : super(key: key);

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  late BoxDecoration decoration;
  late Widget loadingWidget;
  double height=50.h,width=100.w;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController( // (a).
      vsync: this, // (b).
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.2,
    )..addListener(() { // (c).
      setState(() {});
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //_animationController.dispose();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    buildDecoration();
    buildLoadingWidget();
  }

  void buildDecoration() {
    ButtonDecoration bd = !widget.isEnable! ? ButtonDecoration.Flat : widget.buttonDecoration;
    decoration = (widget.decoration !=null ? widget.decoration:
        bd == ButtonDecoration.Flat ? BoxDecoration(
          color: widget.isEnable! ? widget.backgroundColor ?? AppColor.primary2 : AppColor.buttonDisableColor,
          borderRadius: BorderRadius.circular(widget.radius ?? 5.r),
        ):BoxDecoration(
          color: widget.isEnable! ? widget.backgroundColor ?? AppColor.primary2 : AppColor.buttonDisableColor,
          borderRadius: BorderRadius.circular(widget.radius ?? 5.r),
            boxShadow: [
              BoxShadow(
                color: (widget.backgroundColor ?? AppColor.primary2).withOpacity(0.25),
                blurRadius: 16.r,
                offset: Offset(0.0, 5),
              ),
            ],
        ))!;
  }

  void buildLoadingWidget() {
    loadingWidget = widget.loadingWidget ??
        SizedBox(
          width: 25,
          height: 25,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColor.buttonTextColor),
              strokeWidth: 2,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    buildDecoration();
    return AbsorbPointer(
      absorbing: !widget.isEnable!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: GestureDetector(
              onTap: widget.isLoading ? null : widget.onPressed,
              onTapDown: _tapDown,
              onTapUp: _tapUp,
              child: Transform.scale( // (b).
                scale: 1 - _controller!.value, // (c).
                child: AnimatedContainer(
                  padding: widget.isLoading ? EdgeInsets.all(10) : widget.paddingEnable ? const EdgeInsets.only(top: 3, bottom: 3).r : EdgeInsets.zero,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  decoration: widget.isLoading ? decoration.copyWith(borderRadius: BorderRadius.circular(100)) : decoration,
                  child: widget.isLoading ? loadingWidget : widget.child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _tapDown(TapDownDetails details) {
    _controller!.forward();
  }

  // (f).
  void _tapUp(TapUpDetails details) {
    _controller!.reverse();
  }
}


class SpriteDemo extends StatefulWidget {
  @override
  SpriteDemoState createState() =>  SpriteDemoState();
}

class SpriteDemoState extends State<SpriteDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync:this,duration: Duration(seconds: 2));
    _animationController.repeat(reverse: true);
    _animation =  Tween(begin: 2.0,end: 15.0).animate(_animationController)..addListener((){
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(255, 27, 28, 30),
          boxShadow: [BoxShadow(
              color: Color.fromARGB(130, 237, 125, 58),
              blurRadius: _animation.value,
              spreadRadius: _animation.value
          )]
      ),
      child: Icon(Icons.mic,color: Colors.white,),
    );
  }
}
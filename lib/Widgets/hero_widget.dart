import 'package:flutter/material.dart';

Widget HeroWidget({required String tag,required Widget child}){

  return Hero(
    tag: tag,
    flightShuttleBuilder: (BuildContext flightContext,
        Animation<double> animation,
        HeroFlightDirection flightDirection,
        BuildContext fromHeroContext,
        BuildContext toHeroContext,){

      return SingleChildScrollView(
        child: fromHeroContext.widget,
      );
    },
    child: Material(
      color: Colors.transparent,
      child: child,
    ),
  );
}

class CustomRectTween extends RectTween {
  CustomRectTween({Rect? begin, Rect? end})
      : super(begin: begin, end: end) {}

  @override
  Rect lerp(double t) {

    double height = end!.top - begin!.top;
    double width = end!.left - begin!.left;

    Cubic easeOutQuad = const Cubic(0.25, 0.46, 0.45, 0.94);

    double transformedY = easeOutQuad.transform(t);

    double animatedX = begin!.left + (t * width);
    double animatedY = begin!.top + (transformedY * height);

    return Rect.fromLTWH(animatedX, animatedY, 1, 1);
  }
}
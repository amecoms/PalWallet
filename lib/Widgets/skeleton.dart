import 'dart:async';

import 'package:flutter/material.dart';
class Skeleton extends StatefulWidget {
  Widget child;

  Skeleton({required this.child});

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> {
  ValueNotifier<double> opacity = ValueNotifier(0.8);
  Duration duration = const Duration(milliseconds: 1200);
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(duration, (timer) {
      opacity.value=opacity.value == 0.8 ? 0.3 : 0.8;
    });
  }


  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: opacity,
      builder: (context,value,child){
        return AnimatedOpacity(
          opacity: value,
          duration: duration,
          child: widget.child,
        );
      }
    );
  }
}
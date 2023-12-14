import 'dart:async';

import 'package:flutter/material.dart';

class DynamicSizeWidget extends StatefulWidget {
  Widget child;
  Function(double height, double width)? onGetSize;


  DynamicSizeWidget({required this.child, this.onGetSize});

  @override
  _DynamicSizeWidgetState createState() => _DynamicSizeWidgetState();
}

class _DynamicSizeWidgetState extends State<DynamicSizeWidget> {
  GlobalKey stickyKey = GlobalKey();

  @override
  void initState(){
    super.initState();
    getHeight();
  }

  @override
  void didUpdateWidget(DynamicSizeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    getHeight();
  }

  getHeight(){
    if(widget.onGetSize!=null) {
      Timer(const Duration(milliseconds: 50), () {
        try {
          final keyContext = stickyKey.currentContext;
          final box = keyContext!.findRenderObject() as RenderBox;
          widget.onGetSize!(box.size.height,box.size.width);
        }
        catch (e) {
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: stickyKey,
      child: widget.child,
    );
  }
}

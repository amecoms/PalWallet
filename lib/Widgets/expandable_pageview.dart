import 'package:flutter/material.dart';
import '../Widgets/size_report_widget.dart';

class ExpandablePageView extends StatefulWidget {
  List<Widget> children;
  PageController controller;
  ScrollPhysics? physics;
  ExpandablePageView({
    Key? key,
    required this.controller,
    required this.children,
    this.physics,
  }) : super(key: key);

  @override
  _ExpandablePageViewState createState() => _ExpandablePageViewState();
}

class _ExpandablePageViewState extends State<ExpandablePageView> with TickerProviderStateMixin {
  List<double>? _heights;
  int _currentPage = 0;
  int _prevPage = 0;

  ValueNotifier<double> currentHeight = ValueNotifier<double>(100);

  @override
  void initState() {
    _heights = widget.children.map((e) => 0.0).toList();
    super.initState();
    widget.controller.addListener(() {
        final newPage = widget.controller.page!.round();
        if (_currentPage != newPage) {
          _prevPage = _currentPage;
          _currentPage = newPage;
          currentHeight.value = _heights![_currentPage];
        }
      });
  }


  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
        valueListenable: currentHeight,
        builder: (context,value,child){
          return TweenAnimationBuilder<double>(
            curve: Curves.easeInOutCubic,
            duration: const Duration(milliseconds: 100),
            tween: Tween<double>(begin: _heights![_prevPage], end: value),
            builder: (context, value, child) => SizedBox(height: value, child: child),
            child: PageView(
              controller: widget.controller,
              physics: widget.physics,
              children: _sizeReportingChildren
                  .asMap() //
                  .map((index, child) => MapEntry(index, child))
                  .values
                  .toList(),
            ),
          );
        }
    );
  }

  List<Widget> get _sizeReportingChildren => widget.children.asMap().map((index, child) => MapEntry(index,
      OverflowBox(
        minHeight: 0,
        maxHeight: double.infinity,
        alignment: Alignment.topCenter,
        child: SizeReportingWidget(
          onSizeChange: (size) {
            _heights![index] = size.height;
            if(index == _currentPage){
              currentHeight.value = _heights![_currentPage];
            }
          },
          child: Align(child: child),
        ),
      ),
    ),
  ).values.toList();
}

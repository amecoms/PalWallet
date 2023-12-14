import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widgets/dynamic_sIze_widget.dart';
import '../theme/app_color.dart';

class Header extends StatefulWidget {
  String title;


  Header({required this.title});

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  double titleWidth = 0;

  void changeState(){
    if(mounted){
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return DynamicSizeWidget(
      onGetSize: (height,width){
        titleWidth=width;
        changeState();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title,style: Theme.of(context).textTheme.headline1,),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            margin: const EdgeInsets.only(top: 5).r,
            height: 5.h,
            width:titleWidth*0.7,
            decoration: BoxDecoration(
                color: AppColor.primary2,
                borderRadius: BorderRadius.circular(5.r)
            ),
          ),
        ],
      ),
    );
  }
}

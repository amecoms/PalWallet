import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../main.dart';

class EmptyPage extends StatelessWidget {
  final String message;
  final String image;
  const EmptyPage({Key? key,required this.message,required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          40.verticalSpace,
          SvgPicture.asset(image,width: 1.sw,),
          40.verticalSpace,
          Text(message,textAlign: TextAlign.center,style: appTheme().textTheme.bodyText1,),
        ],
      ),
    );
  }
}

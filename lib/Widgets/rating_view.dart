/*
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_color.dart';

class RatingView extends StatelessWidget {
  final double rating;
  final double? iconSize;
  final bool ignoreGestures;
  final Function(double)? onChange;
  final Color? unratedColor;
  const RatingView({required this.rating, this.ignoreGestures = true, this.iconSize,this.onChange,this.unratedColor,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
        initialRating: rating,
        minRating: 0,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: EdgeInsets.zero,
        ignoreGestures: ignoreGestures,
        itemSize: iconSize ?? 14.r,
        unratedColor: unratedColor ?? Colors.grey[200],
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: AppColor.yellow,
        ),
        onRatingUpdate: (rating) {
          if(onChange!=null){
            onChange!(rating);
          }
        },
    );
  }
}
*/

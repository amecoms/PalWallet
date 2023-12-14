import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Widgets/widget_validation.dart';
import '../main.dart';
import '../theme/app_color.dart';
import 'dimension.dart';
class DesignComponent{
  static List<BoxShadow> get  dropShadow => [
    BoxShadow(
      blurRadius: 6,
      offset: const Offset(0, 3),
      color: AppColor.shadowColor,
    )
  ];
  static ShapeBorder cardShape({double? radius}){
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius ?? 10.r)
    );
  }

  static TextStyle textUnderline({Color? color}){
    return TextStyle(
      shadows: [
        Shadow(
            color: color ?? AppColor.primary,
            offset: Offset(0, -2.r)
        )
      ],
      color: Colors.transparent,
      decoration: TextDecoration.underline,
      decorationColor: color ?? AppColor.primary,
    );
  }

  static BoxDecoration emptyDecoration({Color? color}){
    return BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(5.r),
      boxShadow: [
        BoxShadow(color: color ?? AppColor.grey,),
        BoxShadow(
          color: AppColor.buttonTextColor,
          spreadRadius: -10.0.r,
          blurRadius: 10.0.r,
        ),
      ],
    );
  }
  static Future<dynamic> showBottomSheetPopup({BuildContext? context, required Widget child, bool isScrollControlled = false}) async {
    return await showModalBottomSheet(
      context: context ?? appContext,
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      isScrollControlled: isScrollControlled,
      builder: (context) {
        return  child;
      },
    );
  }

  static Widget sectionView({required String label, String? subLabel,required String? Function(dynamic) validator, required Widget child, EdgeInsetsGeometry? padding}){
    return WidgetValidation(
      validator: validator,
      crossAxisAlignment: CrossAxisAlignment.start,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: appTheme().textTheme.bodyLarge),
          6.verticalSpace,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColor.dividerColor),
              color: AppColor.textFieldBackground
            ),
            padding: padding ?? REdgeInsets.symmetric(horizontal: 16,vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (subLabel == null)
                        4.verticalSpace,
                      Visibility(
                        visible: subLabel != null,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(subLabel ?? '', style: appTheme().textTheme.bodyMedium!.copyWith(
                                fontWeight: Dimension.textRegular
                            ),),
                            4.verticalSpace,
                          ],
                        ),
                      ),
                      child
                    ],
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded)
              ],
            ),
          ),
        ],
      ),
    );
  }
}